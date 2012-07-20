# encoding: utf-8

module TrackerFilter
  # commerce_code があるかチェックして、あるときはログをとっておく
  def add_tracker_code
    #tracker = params[:tracker]
    tracker = params[:e_code]
    return unless tracker
    #return if session[:__tracker] # テーブルに複数回値を保存しない

    Rails.logger.info " add_tracker_code : #{request.remote_ip}, tracker_code : #{tracker} "

    log = TrackerLog.add( request.remote_ip, tracker )
    session[:__tracker] = log.session_id
  rescue => e
    Rails.logger.error e
  end

  # 入会説明ページに来た時には、それを成果としてログに保存しておく
  def entry_tracker_code
    Rails.logger.info "entry_tracker_code"
    return unless session[:__tracker]

    Rails.logger.info " __tracker_code : #{session[:__tracker]} "
    log = TrackerLog.entry( session[:__tracker], @user_id, @carrier )
    logger.info log.inspect
    log
  rescue => e
    Rails.logger.error e
  end

  # 入会が完了した時に、commerce_codeに完了フラグを入れておく
  def complete_tracker_code
    Rails.logger.info "complete_tracker_code"

    return unless @user_id

    Rails.logger.info " user_id : #{@user_id} "

    # ログの取引完了フラグを更新する(時間）
    logger.info TrackerLog.complete( @user_id ).inspect
    # セッションをクリア
    session[:__tracker] = nil
  rescue => e
    Rails.logger.error e
  end
end
