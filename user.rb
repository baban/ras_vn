# encoding: utf-8
class User < ActiveRecord::Base
  include Rails.application.routes.url_helpers
  include Abilie::Redis::User
  self.default_url_options = {:host => Settings.mail.host }

  attr_accessor :password, :password_validation_flag, :current_password
  validates :password, :confirmation => true, :length => { :within => 4..32 }, :if => lambda{ new_record? || self.password_validation_flag.present?}
  validates :email, :email => true
  validates :image, :presence => true
  validates :name, :presence => true, :length => { :maximum => 50 }
  validates :url_name, :uniqueness => true, :allow_nil => true,
                        :exclusion => { :in => ["new", "create", "show", "edit", "update", "complete", "authenticated", "verify_email", "notfound"]}
  
  validates :description, :length => { :maximum => 500 }

  validates_format_of :url_name, :with => /^[_a-zA-Z\d-]+$/, :allow_nil => true
  validates :sex, :format => /^[1-2]$/

  validates_acceptance_of :accept

  has_many :tickets, :order => "id DESC", :dependent => :destroy

  # サポートしている
  has_many :friendships, :dependent => :destroy
  has_many :friends, :through => :friendships ,:order => "id DESC"

  #サポートされている
  has_many :followerships, :class_name => "Friendship",:foreign_key => :friend_id, :dependent => :destroy
  has_many :followers, :through => :followerships, :source => :user,:order => "id DESC"

  has_many :activities, :order => "id DESC", :dependent => :destroy, :class_name => "Activity"

  has_many :notifications, :dependent => :destroy
  has_many :recipient_notifications, :order => "id DESC", :dependent => :destroy, :class_name => "Notification", :foreign_key => "recipient_user_id", :include => :user
  has_many :notes, :dependent => :destroy
  has_many :note_comments

  # 購入したチケット
  has_many :purchases, :dependent => :destroy

  has_many :attachments, :dependent => :destroy

  # 利用明細 
  has_many :bills, :dependent => :destroy
  has_many :payments, :class_name => "Bills::Payment", :foreign_key => :user_id
  has_many :incomes, :class_name => "Bills::Income", :foreign_key => :user_id

  # メッセージ
  has_many :messages, :dependent => :destroy

  # 連携した外部サービス
  has_many :services, :dependent => :destroy

  # 統計的なアレ
  has_many :reports

  # 出品者情報
  has_one :exhibitor, :dependent => :destroy

  # リクエストメッセージ
  has_many :request_messages
  has_many :wants

  # おすすめユーザー
  has_one :recommend_user
  # 書いたレビュー
  has_many :reviews

  # キャンペーン参加情報
  has_many :campaign_entries

  # 閲覧できる動画
  has_many :watchable_videos, :foreign_key => :user_id, :dependent => :destroy

  # お知らせメール設定
  has_one :notification_setting

  # TODO あとでなおす
  #attr_protected :url_name, :email, :birthday 
  attr_protected :salt, :encrypt_password, :secure_signined_at

  mount_uploader :image, ProfileUploader

  # お知らせのカウント最大数
  NOTIFICATION_MAXIMUM = 5

  SEX_TYPES = { 
    1 => "男",
    2 => "女"
  } 

  scope :subscriber, where("subscribe_flag = 1")
  scope :verified_email, where("verify_email_flag = 1")
  scope :recommend, lambda { |user| where("users.id != ?", user).order("followers_count DESC")}
  scope :only_exhibitor, where(:exhibitor_flag => true)
  scope :admin, where("admin_type > 0")
  scope :recent, order("created_at DESC")
  scope :active, where(:delete_flag => false)
  scope :accept_request, where("refuse_request_flag= 0")
  scope :premium, where("premium_status > 0")
  scope :random, lambda { |*args| { :order=>'RAND()', :limit=>args[0] || 1 } }

  before_save :encrypt_password

  ADMIN_TYPE = {
    "guest" => 0,
    "abilie" => 1,
    "user_communication" => 2,
    "financial_affairs" => 3,
    "developer" => 4
  }

  PREMIUM_STATUS = {
    "normal" => 0,
    "semi_vip" => 1,
    "vip" => 2
  }

  # 自分かどうかを判定
  def own?(user)
    self.id == user.id
  end

  # チケットの出品者が自分かどうか
  def owner?(ticket)
    self.id == ticket.user_id
  end

  # 指定したユーザーをサポート済みかどうかを判定
  def followed?(user)
    @friends ||= self.friends.where("friendships.user_id = ?", self.id).map(&:id)
    @friends.include?(user.id)
  end

  # 指定したチケットをイチオシにする
  def recommend(ticket)
    recommend_ticket = Ticket.find ticket
    self.recommended_ticket = recommend_ticket.id
    self.save!
  end

  # 指定したユーザーを応援する
  def follow(user)
    User.transaction do
      friend = self.friendships.create(:friend_id => user.id)
      self.friends_count += 1
      self.save!
      user.followers_count += 1
      user.save!
    end
  end

  # 指定したユーザーの応援をやめる
  def unfollow(user)
    friendship = Friendship.find_by_user_id_and_friend_id!(self.id, user.id)
    User.transaction do
      friendship.destroy
      self.friends_count -= 1 
      self.save
      user.followers_count -= 1
      user.save
    end
  end

  # 管理者かどうか
  def admin?
    self.admin_type != ADMIN_TYPE["guest"]
  end

  # プレミアムかどうか
  def premium?
    self.premium_status != PREMIUM_STATUS["normal"]
  end

  # ユーザのアドミンタイプを変更する
  def change_admin!(type)
    if ADMIN_TYPE.has_key?(type)
      self.admin_type = ADMIN_TYPE[type]
    else
      self.admin_type = ADMIN_TYPE["guest"]
    end
    self.save!
  end

  # ユーザのプレミアムステータスを変更する
  def change_premium!(type)
    if PREMIUM_STATUS.has_key?(type)
      self.premium_status = PREMIUM_STATUS[type]
    else
      self.premium_status = PREMIUM_STATUS["normal"]
    end
    self.save!
  end

  # チケットを購入する
  def purchase!(ticket, transaction_id = nil, commit_request_at = nil, affiliate_id = nil)
    if self.purchasable?(ticket)
      self.transaction do
        purchase = Purchase.create!(:ticket_id => ticket.id, :user_id => self.id, :cost => ticket.price, :transaction_id => transaction_id, :commit_request_at => commit_request_at, :affiliate_id => affiliate_id)
        ticket.stock -= 1
        # 在庫が0になれば販売終了にする
        ticket.close! if ticket.stock == 0
        # 最終購入日を更新する
        ticket.last_purchased_at = purchase.created_at
        ticket.save!

        # 購入の利用明細に記録
        Bills::Payment.enter_bill!(self, purchase)

        # 売り上げの利用明細に記録
        Bills::Income.enter_bill!(ticket.user, purchase)

        # メッセージを送信可能な状態にする
        conversation = Conversation.create!(:purchase => purchase)
        conversation.conversation_members.create!(:user_id => self.id)
        conversation.conversation_members.create!(:user_id => ticket.user_id)

        # 同一トランザクションidのtmp_purchaseを削除する
        TmpPurchase.where(:transaction_id => transaction_id).delete_all if transaction_id
      end
      true
    else
      false
    end
  end

  def purchasable?(ticket)
    # 公開中のものしか買えない
    return false unless ticket.opening?
    # 自分が出品したものは買えない
    return false if self.owner?(ticket)
    # 購入済みのものは買えない
    # return false if self.purchased?(ticket)
    true
  end

  # チケットが購入済みかどうか
  def purchased?(ticket)
    self.purchases.where(:ticket_id => ticket.id).present?
  end

  # ボードを投稿する
  def board!(params = {})
    note = self.notes.build params[:note]
    if params[:reply_to].present?
      reply_user = User.find_by_url_name params[:reply_to]
      note.in_reply_to_user = reply_user
    end
    if params[:ticket_id].present?
      ticket = Ticket.viewable.find_by_id params[:ticket_id]
      note.ticket = ticket 
    end
    note.save!
    note
  end


  # 引数のユーザーにメッセージが送信可能かどうか
  def sendable_message?(user = nil)
    unless user.blank?
      conversation_ids = ConversationMember.where(:user_id => self.id).pluck(:conversation_id)
      ConversationMember.where(:user_id => user.id).where(:conversation_id => conversation_ids).present?
    else
      ConversationMember.where(:user_id => self.id).limit(1).present?
    end
  end

  def conversation(purchase)
    conversation_ids = ConversationMember.where(:user_id => self.id).pluck(:conversation_id)
    Conversation.where(:purchase_id => purchase).where(:id => conversation_ids).last.id
  end 

  # マイページに流すタイムライン
  def timeline
    users = [self.id] + self.friends.map(&:id)
    Activity.includes(:user).where(:user_id => users).recent
  end

  # メール実在確認用のURLを作成する
  def create_verify_url
    auth_code = create_auth_code(:verify)
    protocol = SslRequirement.disable_ssl_check? ? "http" : "https"
    verify_email_users_url("auth_code" => auth_code, :protocol => protocol)
  end

  def verify(auth_code)
    user_id = User.find_user_id_by_auth_code(:verify, auth_code)
    if self.id == user_id.to_i
      self.verify_email_flag = true
      self.save!
      User.delete_auth_code(:verify, auth_code)
    else
      false
    end
  end

  # 口座情報が未登録かどうか
  def has_bank_account?
    self.exhibitor && self.exhibitor.bank_name.present?
  end

  # 現在のパスワードと等しいかどうか
  def correct_password?(password)
    self.encrypted_password == Digest::SHA2.hexdigest("#{self.salt}:#{password}")
  end

  # セキュアなページにログイン中かどうかを判定
  def secure_signined?
    return false if self.secure_signined_at.blank?
    self.secure_signined_at > 1.hours.ago
  end

  # パスワード再設定のためのtokenを発行する
  def create_reset_password_url
    auth_code = create_auth_code(:reset_password)
    protocol = SslRequirement.disable_ssl_check? ? "http" : "https"
    edit_reset_password_url("token" => auth_code, :protocol => protocol)
  end

  def increase_notifications_count
    if self.notifications_count < NOTIFICATION_MAXIMUM  
      self.notifications_count += 1
      self.save!
    end
  end

  def reset_notifications_count
    if self.notifications_count > 0  
      self.notifications_count = 0
      self.save!
    end
  end

  # type に対応する value を返す。想定外の type が来た場合は 1 を返す。
  def sex_choices(type)
    case type
    when "male"
      return 1
    when "female"
      return 2
    else
      return 1
    end
  end

  def get_sex
    SEX_TYPES[self.sex]
  end

  # 退会処理
  def withdraw!
    # delete_flagを立てるとvalidationに引っかかるためupdate_allしてる
    User.where(:id => self.id).update_all(:delete_flag => true, :subscribe_flag => false)

    # 削除は重いのでresqueで行う
    Resque.enqueue(User, self.id)
  end

  def last_login
    self.last_login_at = Time.now
    self.save
  end

  # リクエストが送れる人がいるかどうか
  # (リクエストを受け付けているフォローしている人がいるかどうか)
  def sendable_request?
    self.friends.accept_request.present?
  end

  # レビューを書くことができるか
  def reviewable?(ticket)
    return false if self.id == ticket.user_id
    return false if ticket.reviewd?(self)
    return true if self.purchased?(ticket)
    false
  end

  # １軍のプレミアムかどうか
  def vip?
    self.premium_status == PREMIUM_STATUS["vip"]
  end

  # 2軍のプレミアムかどうか
  def semi_vip?
    self.premium_status == PREMIUM_STATUS["semi_vip"]
  end

  # delete_flagを見て返す
  def name
    return read_attribute(:name) if new_record?
    return "" if delete_flag
    read_attribute(:name)
  end

  # delete_flagを見て返す
  def description
    return read_attribute(:description) if new_record?
    return "" if delete_flag
    read_attribute(:description)
  end

  # delete_flagを見て返す
  def url_name
    return read_attribute(:url_name) if new_record?
    return "notfound" if delete_flag
    read_attribute(:url_name)
  end

  # delete_flagを見て返す
  def image
    return super if new_record?
    if delete_flag
      notfound_uploader = NotfoundUploader.new self, :image
      notfound_uploader.retrieve_from_store! "noimg.jpg"
      notfound_uploader
    else
      super
    end
  end

  # Softbank Paymentの顧客コード
  def cust_code
    "#{Rails.env}_#{self.id}"
  end

  # Facebook, Twitterへのマルチポスト
  # model: 投稿したいリソース
  # share_options: 
  def multi_post(model, share_options)
    return if share_options.blank?
    self.services.each do |service|
      if share_options[service.service_name]
        case model
        when Note
          service.board(model)
        when Review
          service.review(model)
        when NoteComment
          service.board_comment(model)
        when RequestMessage
          service.request_message(model)
        end
      end
    end
  end

  # tmp_userの値を元に初期化
  def self.init_with_tmp_user(tmp_user)
    user_info = tmp_user.value["info"]
    self.new do |u|
      u.name = user_info["name"]
      if user_info["nickname"].present?
        u.url_name = user_info["nickname"].gsub("\.", "")
      end
      u.email = user_info["email"]
      u.subscribe_flag = true 
      begin
        u.remote_image_url = Service.child_class(tmp_user.value["provider"]).get_original_image(user_info["image"]) if user_info["image"].present?
      rescue CarrierWave::IntegrityError
      end
    end
  end

  # resqueで使うQUEUEの名前
  def self.queue
    :abilie
  end

  # ユーザ退会時に関連情報を削除 
  # bills,conversations,exhibitors,messages,payments,reviews は残す
  def self.perform(user_id)
    user = User.find user_id
    # フォロー、被フォローの情報を削除
    user.friends.each do |friend|
      user.unfollow(friend)
    end
    user.followers.each do |follower|
      follower.unfollow(user)
    end
    # 退会ユーザーのアクティビティを削除
    activity_ids = Activity.where(:user_id => user_id).select(:id)
    ActivityResource.where(:activity_id => activity_ids).delete_all
    Activity.where(:user_id => user_id).delete_all

    # ノート、コメント、付いたコメントのアクティビティを削除
    note_ids = Note.where(:user_id => user.id).select(:id).all
    note_comment_ids = NoteComment.where("user_id = ? OR note_id IN (?)", user_id, note_ids).all
    activity_ids = Activities::NoteComment.joins(:activity_resource).where("activity_resources.resource_id IN (?)", note_comment_ids).all
    Activity.where(:id => activity_ids).delete_all
    Note.where(:id => note_ids).delete_all
    NoteComment.where(:id => note_comment_ids).delete_all

    # Notificationを削除
    Notification.where(:user_id => user_id).delete_all
    Notification.where(:recipient_user_id => user_id).delete_all
    # マイレポートを削除
    Report.where(:user_id => user_id).delete_all
    # uidとTokenを削除
    Service.where(:user_id => user_id).delete_all
    # 公開中のチケットは販売終了に
    Ticket.where(:user_id => user.id).where(:release_status => Ticket::RELEASE_STATUS["opening"]).update_all(:release_status => Ticket::RELEASE_STATUS["closed"])
    # みんなのリクエスト関連削除
    request_message_ids = RequestMessage.where(:user_id => user_id).pluck(:id)
    if request_message_ids.present?
      # 誰かにリクエストしたものに欲しいがついていた場合Notificationsを削除
      want_ids = Want.where(:request_message_id => request_message_ids).pluck(:id)
      Notifications::Want.where(:resource_id => want_ids).delete_all if want_ids.present?
      want_activity_ids = Activities::Want.joins(:activity_resource).where("activity_resources.resource_id IN (?)", want_ids).all
      Activity.where(:id => want_activity_ids).delete_all

      # 退会したユーザーがリクエストしたものに答えたチケットの関連を削除
      Ticket.where(:request_message_id => request_message_ids).update_all(:request_message_id => 0)
      RequestMessage.where(:id => request_message_ids).delete_all 
      # 退会したユーザーがリクエストしたものについているほしいを削除
      Want.where(:request_message_id => request_message_ids).delete_all
    end
    # 退会したユーザがほしいしたものを削除
    Want.where(:user_id => user_id).delete_all
    # 退会したユーザがお気に入りしたものを削除
    Favorite.where(:user_id => user_id).delete_all
  end

  # ユーザーを検索する
  def self.search_query(query)
    users = User.scoped 
    unless query.blank?
      query.split(/\s|　/).each do |s|
        users = users.where("concat(name, description) like ?", "%#{s}%") 
      end
    end
    users
  end

  # ユーザーの年齢を取得する
  def age
    (Time.now.strftime("%Y%m%d").to_i - self.birthday.strftime("%Y%m%d").to_i)/10000
  end

  # メールを受信可能か(退会していなくてメール確認済み)
  def mail_receivable?
    !self.delete_flag && self.verify_email_flag
  end

  private
  # パスワードを暗号化する
  def encrypt_password
    self.salt = Digest::SHA2.hexdigest("#{Time.now}:#{self.password}") if new_record?
    self.encrypted_password = Digest::SHA2.hexdigest("#{self.salt}:#{self.password}") if self.password
  end
end
