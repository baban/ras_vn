# encoding: utf-8

class RecommentRecipeMail < ActiveRecord::Base

  def self.send_mail_magazines
    self.create_mail_buffers( self.mail_senders_info )
  end

  # set mail fatas mail buffer table
  def self.create_mail_buffers( profiles )
    Rails.logger.info "mail buffer : create start"

    # get today's mail data
    tmpl = self.todays_data
    recipe = Recipe.find_by_id(tmpl.recipe_id)

    return false if !tmpl or !recipe

    profiles.find_each( batch_size: 500 ) do |profile|
      self.create_mail_buffer( profile, tmpl, recipe )
    end

    Rails.logger.info "mail buffer : create end"

    true
  end

  def self.todays_data
    self.where( day: Date.today ).first
  end

  # mail sendable users
  def self.mail_senders_info
    users = User.where( retire_flg: false ).select(:id)
    UserProfile.where( mail_status: 1 ).where( " user_id IN (#{users.to_sql}) " )
  end

  def self.create_mail_buffer( profile, mail, recipe )
    mail = MagazineMailer.recipe_magazine( profile, mail, recipe )
    MailBuffer.create!( user_id: profile.user_id, from: mail.from, to: mail.to, subject: mail.subject, body: mail.body )
  rescue => e
    Rails.logger.error " magazine create error : #{profile.inspect} : #{e.inspect} "
  end
end

