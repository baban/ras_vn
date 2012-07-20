# encoding: utf-8

module Filters::Affiriate
  # アフィリエイトの値をセッションに保存する
  def add_affriate_session
    if request.mobile?
    else request.smart_phone?
      aff_code, aff_type = ::Affiriate.check_affriate_code( params )
      if aff_type
        logger.info " save affriate session : #{aff_type}, #{aff_code} "
        session[:_affiriate] = aff_code
        session[:_affiriate_type] = aff_type
        logger.info "_affiriate : #{session[:_affiriate]} : _affiriate_type : #{session[:_affiriate_type]} "
      end
    end
  end

  # commerce_code があるかチェックして、あるときはログをとっておく
  def add_affiriate_code
    Rails.logger.info "add_affiriate_code"
    Rails.logger.info "session : #{session.inspect}"

    return unless session[:_affiriate] # テーブルに複数回値を保存しない
    Rails.logger.info "add_affiriate_code!"

    # アフィリエイト対応作業
    logger.info Affiriate.add_log( @user_id, session[:_affiriate], session[:_affiriate_type], @carrier ).inspect
  rescue => e
    Rails.logger.error e
  end

  # 入会が完了した時に、commerce_codeに完了フラグを入れておく
  def entry_affiriate_code
    Rails.logger.info "entry_affiriate_code"

    logger.info Affiriate.new(@user).entry.inspect
    session[:_affiriate] = session[:_affiriate_type] = nil
  rescue => e
    Rails.logger.error e
  end

  # 入会が完了した時に、commerce_codeに完了フラグを入れておく
  def retire_affiriate_code
    Rails.logger.info "retire_affiriate_code"
    return unless @user

    Rails.logger.info " user_id : #{@user.inspect} "

    logger.info Affiriate.new(@user).retire.inspect
    session[:_affiriate] = session[:_affiriate_type] = nil
  rescue => e
    Rails.logger.error e
  end
end
