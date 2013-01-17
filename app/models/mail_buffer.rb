# encoding: utf-8

class MailBuffer < ActiveRecord::Base
  validates :user_id,  presence: true
  validates :from,     presence: true
  validates :reply_to, presence: true
  validates :bcc,      presence: true
  validates :subject,  presence: true
  validates :body,     presence: true

  def self.send_mail_magazines
    self.create_mail_buffers
    self.send_mail_buffers
  end

  # set mail fatas mail buffer table
  def self.create_mail_buffers
    Rails.logger.info "mail buffer : create start"

    # get today's mail data
    mail = MailTemplate.todays_mail
    return false unless mail

    profiles = self.mail_senders_info
    profiles.find_each( batch_size: 500 ) do |profile|
      self.create_mail_buffer( profile, mail )
    end
    Rails.logger.info "mail buffer : create end"
    true
  end

  # mail sendable users
  def self.mail_senders_info
    UserProfile.where( mail_status: true )
  end

  def self.create_mail_buffer( profile, mail )
    mail = MagazineMailer.magazine( profile, mail )
    row = {
      user_id: profile.user_id,
      email: profile.mail_address,
      from: mail.magazine_from,
      reply_to: mail.magazine_reply,
      bcc: mail.magazine_bcc,
      subject: mail.subject,
      body: mail.contents,
    }

    buffer = self.create( row, without_protection: true )
  end

  # send mail magazines
  def self.send_mail_buffers
    Rails.logger.info "send mail buffers:start"
    self.find_each do |buffer|
      mail = MagazineMailer.magazine( buffer )
      next if mail
      begin
        mail.deliver
      rescue => e
        Rails.logger.error " mail send error : #{mail.inspect} "
        FailMail.set_fail_mail( buffer.to )
      end
    end
    Rails.logger.info "send mail buffers:end"
  end
end
