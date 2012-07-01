# encoding: utf-8

class Devise::RegistrationsController < DeviseController
  def mail_sended
  end

  def after_sign_up_path_for(resource)
    logger.info "hoego"
    return url_for(action:"mail_sended")
  end
end
