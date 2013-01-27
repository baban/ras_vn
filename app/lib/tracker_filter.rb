# encoding: utf-8

module TrackerFilter
  # check tracker code parameter, and if tracker exist, save tracker_log table
  def add_tracker_code
    tracker = params[:tracker]
    return unless tracker

    Rails.logger.info " add_tracker_code : #{request.remote_ip}, tracker_code : #{tracker} "

    log = TrackerLog.add( request.remote_ip, tracker )
    session[:__tracker] = log.session_id
  rescue => e
    Rails.logger.error e
  end

  # bind user_id to tracker session_id
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

  # when user is entrying, entry time set
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
