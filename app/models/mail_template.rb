# encoding: utf-8

class MailTemplate < ActiveRecord::Base
  validates :title,    presence: true
  validates :content,  presence: true
  validates :from,     presence: true
  validates :reply_to, presence: true

  scope :visibles, -> { where( " public = true " ).where( " opened_at IS NULL OR opened_at < ? ", Time.now ).where( " closed_at IS NULL OR closed_at > ? ", Time.now )  }

  def self.todays_mail
    self.visibles.first
  end

  def self.squueze_recipe_ranking
    
  end
end
