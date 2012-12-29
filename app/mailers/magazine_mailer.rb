# encoding: utf-8

class MagazineMailer < ActionMailer::Base
  default from: "info@cook24.vn"

  def magazine( buffer )
    @buffer = buffer
    mail( subject: @buffer.subject, from: @buffer.from, to: @buffer.to, 'Reply-to' => @buffer.reply_to )
  end
end
