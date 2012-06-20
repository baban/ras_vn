# encoding: utf-8

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  has_one :user_profile
  alias :profile :user_profile

  accepts_nested_attributes_for :user_profile
  attr_accessible :user_profile, :user_profile_attributes

  has_many :recipes
  has_many :bookmarks

  belongs_to :recipe

  def initialize(*args)
    super(*args)
    self.user_profile = UserProfile.new
  end

  # ブックマークされたレシピを返す
  def bookmarked_recipes
    self.bookmarks.pluck(:recipe_id).do{ |ids| Recipe.where( " id in (?) ", ids ) }
  end

end
