# encoding: utf-8

class MagazineMailer < ActionMailer::Base
  default from: "info@cook24.vn"

  def magazine( profile, buffer )
    @buffer = buffer
    @profile = profile
    mail( subject: @buffer.title, from: @buffer.from, to: @profile.email, 'Reply-to' => @buffer.reply_to )
  end
end
