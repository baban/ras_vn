# encoding: utf-8

class UserMailer < ActionMailer::Base
  default from: "info@cook24.vn"

  def welcome( email )
    @email = email
    mail( subject: "welcome", to: email )
  end
end

