# encoding: utf-8

class TrackerLog < ActiveRecord::Base
  # 来訪手段を記録する
  def self.add( ip_address, tracker_code )
    session_id = "#{ip_address}:#{Time.now.strftime('%Y%m%d%H%M%S')}"
    # 作成：24時間以内に課金完了しないと効果がなかったと判断する
    self.create!( session_id: session_id, tracker_code: tracker_code, limit_at: Time.now+1.day )
  end

  # 契約先のユーザーIDが取得できた段階でそれを保存
  # @params [String] user_id 決済相手の発行したユーザーID
  # @params [String] carrier 決済を行ったキャリア（Gree,Docomo,SoftbankPayment,Paypal等わかり易い名前を入れる)
  def self.entry( session_id, user_id=nil, carrier=nil )
    log = self.find_by_session_id( session_id )
    log.user_id = user_id
    log.carrier = carrier
    log.save
    log
  end

  # 取引完了の時間を記録する
  # @param [String] user_id ユーザーID、完了処理が不要の場合はそもそもユーザーIDを取らない
  def self.complete( user_id=nil )
    log = self.where( " user_id = ? ", user_id ).last
    return log unless log
    return log if log.limit_at < Time.now
    log.completed_at = Time.now
    log.user_id = user_id
    log.save
    log
  end

end
