# encoding: utf-8

class User < ActiveRecord::Base
  establish_connection "cook24_users" if [:staging,:production].include?(Rails.env.to_sym)
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :omniuser_id

  has_one :user_profile
  alias :profile :user_profile

  accepts_nested_attributes_for :user_profile
  attr_accessible :user_profile, :user_profile_attributes

  has_many :recipes
  has_many :recipe_comments
  has_many :diaries
  has_many :followers

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"]
      end
    end
  end

  def self.find_for_facebook_oauth( auth, signed_in_resource=nil )
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = User.create( name: auth.extra.raw_info.name,
                          provider: auth.provider,
                          uid: auth.uid,
                          email: auth.info.email,
                          password: Devise.friendly_token[0,20] )
    end
    user
  end

  def self.find_for_twitter_oauth( auth, signed_in_resource=nil )
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = User.create( name: auth.info.nickname,
                          provider: auth.provider,
                          uid: auth.uid,
                          password: Devise.friendly_token[0,20] )
    end
    user
  end

  def initialize(*args)
    super(*args)
    self.user_profile = create_profile(args.last)
  end

  def create_profile(h)
    h = {} unless h.is_a?(Hash)
    profile = UserProfile.new(h[:user_profile_attributes])
    profile.email=h[:email]
    
    profile
  end

  def admin?
    admin
  end

  def bookmarked_recipes
    recipe_ids = Bookmark.where( user_id: self.id ).select(:recipe_id)
    Recipe.where( " id IN (#{recipe_ids.to_sql}) " )
  end
end

