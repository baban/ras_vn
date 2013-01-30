# encoding: utf-8

class RecommentRecipeMail < ActiveRecord::Base
  attr_accessible :day, :recipe_id

  def self.send_mail_magazines
    self.create_mail_buffers
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
    users = User.where( retire_flg: false ).select(:id)
    UserProfile.where( mail_status: 1 ).where( " user_id IN (#{users.to_sql}) " )
  end

end

