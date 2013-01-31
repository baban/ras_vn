# encoding: utf-8

class RecommendRecipeMail < ActiveRecord::Base

  def self.send_mail_magazines
    Rails.logger.info " RecommendRecipeMail.self.send_mail_magazines : START "
    self.create_mail_buffers( self.mail_senders_info )
    Rails.logger.info " RecommendRecipeMail.self.send_mail_magazines : END "
  end

  # set mail fatas mail buffer table
  def self.create_mail_buffers( profiles )
    Rails.logger.info "mail buffer : create start"

    # get today's mail data
    tmpl = self.todays_data

    return !Rails.logger.info(" today's template is not exist ") unless tmpl

    recipe = Recipe.find_by_id(tmpl.recipe_id)

    return !Rails.logger.info(" recipe is not exist ") unless recipe

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
    UserProfile.where( mail_status: 1 ).where( " email IS NOT NULL " ).where( " user_id IN (#{users.to_sql}) " )
  end

  def self.create_mail_buffer( profile, mail, recipe )
    mail = MagazineMailer.recipe_magazine( profile, mail, recipe )
    buffer = MailBuffer.create!( user_id: profile.user_id, from: mail.from, to: mail.to, subject: mail.subject, body: mail.body )
  rescue => e
    Rails.logger.error " magazine create error : #{profile.inspect} : #{e.inspect} "
  end
end

