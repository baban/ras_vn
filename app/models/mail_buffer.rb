# encoding: utf-8

class MailBuffer < ActiveRecord::Base
  validates :user_id,  presence: true
  validates :from,     presence: true
  validates :to,       presence: true
  validates :subject,  presence: true
  validates :body,     presence: true

  def self.send_mail_magazines
    self.create_mail_buffers
    self.send_mail_buffers
  end

  # mail sendable users
  def self.mail_senders_info
    users = User.where( retire_flg: false ).select(:id)
    UserProfile.where( mail_status: 1 ).where( " email IS NOT NULL " ).where( " user_id IN (#{users.to_sql}) " )
  end

  def self.create_mail_buffer( profile, mail )
    # mail = MagazineMailer.magazine( profile, mail )
    row = {
      user_id: profile.user_id,
      email: profile.email,
      from: mail.from,
      bcc: mail.bcc,
      subject: mail.title,
      body: mail.content,
    }

    buffer = self.create( row, without_protection: true )
  end

  # send mail magazines
  def self.send_mail_buffers
    Rails.logger.info "send mail buffers:start"
    self.find_each do |buffer|
      mail = MagazineMailer.magazine( buffer )
      next unless mail
      begin
        mail.deliver
        buffer.delete
      rescue => e
        Rails.logger.error " mail send error : #{mail.inspect} "
        FailMail.set_fail_mail( buffer.to )
      end
    end
    Rails.logger.info "send mail buffers:end"
  end
end
