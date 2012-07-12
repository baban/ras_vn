# -*- coding: utf-8 -*-
module GuideHelper


  MESSAGE_LENGTH = 140
  # 新規作成ページかどうかを返します。
  #
  def new_page?
    current_page?(new_guide_path) || current_page?(guides_path)
  end

  def disabled_option(user_id)
    option = false
    return option unless user_id
    option = true unless login_user && user_id == login_user.id
    option
  end

  def comment_class(reaction_id)
    case reaction_id
    when Comment.reaction_type(:try)
      return "ico_do"
    when Comment.reaction_type(:thanks)
      return "ico_thanks"
    end
  end

  # コメント欄をdiableにするかどうかチェック
  def comment_disabled(login_user)
    login_user.blank?
  end

  # スペース区切りのタグをカンマ区切りに変換する
  # ただし、大文字カンマで区切る
  # サニタイズを含む
  #
  def comma_sep_tag_names(tag_names)
    tag_names.gsub(/\s/, "、")
  end

  # paginateのナビゲーション表示
  #
  def page_info(collection)
    return "#{collection.total_entries}件中 #{collection.offset + 1}-#{[collection.offset + collection.per_page, collection.total_entries].min}件を表示" unless collection.blank?
    "ガイドはありません"
  end

  # 時刻のフォーマット(yyyy/MM/dd hh:mm:ss)
  def format_time(time)
    time_ago_in_words(time, true)
  end

  # %r!hogehoge!は/のエスケープをしなくていい正規表現の使い方
  # 文字列からタグをチェックし、あった場合は正規表現により分解する
  # 指定されたエスケープしないタグがあった場合、attr2hashを呼び出し、属性名がキーで属性値が値になったハッシュを取得
  # タグがもし終了タグでなければ、タグ名からlambdaで指定されたブロックを実行する
  #
  def html_escape_extend(str, option = {:except => []})
    if option[:except].empty?
      html_escape(str)
    else
      allows = option[:except].map{|t|t.downcase}
      str.gsub(%r!(</?)([a-z]+)([^>]*)(/?>)!mi){|tag|
        left, name, attr, right = Regexp.last_match.captures
        if allows.include? name.downcase
          attr = attr2hash(attr)
          if tag !~ /^<\//
            attrs = (ATTR_BUILDER[name.downcase]||ATTR_BUILDER[:default]).call attr
            "#{left}#{name} #{attrs}#{right}"
          else
            "#{left}#{name}#{right}"
          end
        else
          html_escape(tag)
        end
      } if str
    end
  end

  # ガイド一覧の前書きを最大表示文字数以内に整形して表示
  # エスケープを含む
  #
  def truncate_guide(type, str)
    case type
    when :title
      return truncate(str, :length => gap("guide", "truncate_guide_title_length"))
    when :note
      return truncate(str, :length => gap("guide", "truncate_guide_note_length"))
    when :disp_name
      return truncate(str, :length => gap("guide", "truncate_guide_disp_name_length"))
    when :youtube
      return truncate(str, :length => gap(:youtube, :truncate_description_length))
    when :feature
      return truncate(str, :length => gap(:feature, :truncate_guide_note_length)) 
    when :feature_title
      return truncate(str, :length => gap(:feature, :truncate_guide_title_length), :omission => "…")
    when :feature_description
      return truncate(str, :length => gap(:feature, :truncate_guide_ranking_note_length))
    end
  end

  # urlつきで140文字になるようにtruncateをかける
  # TODO 実装すること
  #
  def truncate_for_tweet(model)
    message = model.title
    url = " #{guide_path(:id => model.id, :only_path => false)} #OKGuide"
    message_length = MESSAGE_LENGTH - url.length
    truncate(message, :length => message_length) + url
  end

  # コンテンツが編集可能であるかどうか
  def editable?(content)
    # コブランドでは編集不可能 
    return false if co_brand?
    # 管理者であればすべて編集可能
    # 公式コンテンツ（管理者が作成した）ものは編集不可能
    admin? || !content.official?
  end

  # 属性をスキャンして、属性名をキーに値を配列に格納する
  # ?:はグループ化
  def attr2hash(str)
    str.scan(/([^\s]+?)=(?:'(.+?)'|"(.+?)"|([^ >]+))/i).
        inject({}) {|m, v| m[v[0].intern] = v[1]||v[2]||v[3]; m }
  end

  # 呼び出したブロック内を実行します。
  # a は href, class, target 以外の要素は許可されず、落ちます。
  # img はすべての要素が許可されています。
  # その他のタグは class, style以外の要素が落ちます。
  #
  ATTR_BUILDER = {
    "a" => lambda{|attr|
      if attr[:href] =~ /^https?:/
        attrs = [:class, :target].
          map{|key| "#{key}='#{attr[key]}'" if attr.has_key?(key) }.compact.join(" ")
        "href='#{attr[:href]}' #{attrs}"
      end
    },
    "img" => lambda{|attr|
      attrs = attr.map{|key, value| "#{key}='#{value}'" }.join(" ")
      "#{attrs}"
    },
    :default => lambda{|attr|
      [:class, :style].map{|key|
          "#{key}='#{attr[key]}'" if attr.has_key?(key) }.compact.join(" ")
    }
  }

  alias h html_escape_extend

  # youtubeのURLを展開
  # type: :pc or :touch
  def youtube(val, type = :guide)
    return val if val.blank?
    val.scan(/(http:\/\/www.youtube.com\/watch\?v=([\w\d-]+)[^\s]*)/) do |matches|
      url, video_id = matches
      width = gsc("youtube.#{type.to_s}.width")
      height = gsc("youtube.#{type.to_s}.height")
      val = val.gsub(url,render(:partial => "guides/youtube", :locals => {:video_id => video_id, :width => width, :height => height})).html_safe
    end
    return val
  end

  # こえ部のURLを展開
  def koebu(val)
    return val if val.blank?
    # プレビューや履歴では出さない（JSの関係で出せない）
    return val unless current_page?(:controller => :guides, :action => :show)
    val.scan(/(http:\/\/koebu.com\/koe\/([\w\d]+))/) do |matches|
      url, koebu_id = matches
      val = val.gsub(url,render(:partial => "guides/koebu", :locals => {:koebu_id => koebu_id})).html_safe
    end
    return val
  end

  def tsukuruhito(val)
    return val if val.blank?
    # プレビューや履歴では出さない（JSの関係で出せない）
    return val unless current_page?(:controller => :guides, :action => :show)
    val.scan(/(http:\/\/link.brightcove.co.jp\/services\/player\/bcpid([\d]+))/) do |matches|
      url, tsukuruhito_id = matches
      val = val.gsub(url,render(:partial => "guides/tsukuruhito", :locals => {:tsukuruhito_id => tsukuruhito_id})).html_safe
    end
    return val
  end

  # 改行コードをbrタグに変換
  def br(val)
    return "" if val.blank?
    val.gsub("\n","<br />\n").html_safe
  end
  
  # 改行コードを取り除く
  def except_newline(val)
    val.gsub("\r\n","").gsub("\n","").gsub("\r","")
  end

  def previous_and_next_content(content, options = {})
    previous_content_link = previous_content(content, options[:previous] || '')
    next_content_link = next_content(content, options[:next] || '')
    if next_content_link.present? && previous_content_link.present?
      pipe = options[:pipe] || ' | '
    end
    (previous_content_link + pipe + next_content_link).html_safe
  end

  def next_content(content, next_str = "")
    next_str = html_escape(next_str)
    next_content = content.next_content
    unless next_content.blank?
      link_to(next_content.title, guide_path(next_content)) + next_str
    else
      ""
    end
  end

  def previous_content(content, previous_str = "")
    previous_str = html_escape(previous_str)
    previous_content = content.previous_content
    unless previous_content.blank?
      previous_str + (link_to previous_content.title, guide_path(previous_content))
    else
      ""
    end
  end

  # ガイド新規作成または編集に関する画面かどうかを判定
  #
  def edit_page?
    current_page?(:controller => :guides, :action => :new) || current_page?(:controller => :guides, :action => :create) || current_page?(:controller => :guides, :action => :edit) || current_page?(:controller => :guides, :action => :update)
  end

  #コメントが削除できるかどうか
  def comment_deletable?(comment)
    return false unless login?
    return true if admin?  
    comment.user_id == login_user.id
  end

  def total_guides_count
    Content.total
  end
end
