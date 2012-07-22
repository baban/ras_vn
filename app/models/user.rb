# encoding: utf-8

class User < ActiveRecord::Base
  # users table and user_profiles table are saved data to another database
  establish_connection "ras_vn_users" if [:staging,:production].include?(Rails.env.to_sym)

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :omniuser_id

  has_one :user_profile
  alias :profile :user_profile

  accepts_nested_attributes_for :user_profile
  attr_accessible :user_profile, :user_profile_attributes

  has_many :recipes
  has_many :bookmarks
  has_many :recipe_comments
  has_many :diary

  belongs_to :recipe

  def initialize(*args)
    super(*args)
    self.user_profile = create_profile(args.last)
  end

  def create_profile(h)
    h = {} unless h.is_a?(Hash)
    profile = UserProfile.new(h[:user_profile_attributes])
    profile.mail_address=h[:email]
    
    profile
  end

  # user's bookmarked recipes
  def bookmarked_recipes
    self.bookmarks.pluck(:recipe_id).do{ |ids| Recipe.where( " id in (?) ", ids ) }
  end

  def admin?
    admin
  end
end

