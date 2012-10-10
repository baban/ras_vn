# encoding: utf-8

class Recipe < ActiveRecord::Base
  paginates_per 12

  validates :title, presence: true
  validates :image, presence: true

  has_one  :recipe_draft
  has_many :bookmarks
  has_many :recipe_foodstuffs
  has_many :recipe_steps
  has_many :recipe_comments

  belongs_to :recipe_ranking
  belongs_to :user

  accepts_nested_attributes_for :recipe_steps # use formastic plug-in

  mount_uploader :recipe_image, RecipeImageUploader 

  alias :draft :recipe_draft
  alias :foodstuffs :recipe_foodstuffs
  alias :foodstuffs= :recipe_foodstuffs=
  alias :steps :recipe_steps
  alias :steps= :recipe_steps=
  alias :comments :recipe_comments
  alias :image :recipe_image

  scope :visibles, ->{ where( del_flg: 0 ).where( "public = true" ) }
  scope :topics, -> { visibles.page(1).per(2) }

  alias :chef :user

  def view_count_increment!
    self.view_count+=1
    self.save
  end

  def food
    RecipeFood.find_by_id(self.recipe_food_id)
  end

  # this method is executed when [like] button cliked
  def self.love( params )
    id, user_id = params[:id], params[:user_id]
    recipe = self.find(id)
    recipe.love_count += 1
    recipe.save

    RecipeLoveLog.create( recipe_id: id, user_id: user_id )
    recipe
  end
end

