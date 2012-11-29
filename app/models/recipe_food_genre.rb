# encoding: utf-8

class RecipeFoodGenre < ActiveRecord::Base
  has_many :recipe_foods
  alias :foods :recipe_foods
  mount_uploader :image, RecipeFoodGenreUploader
  scope :topics, ->{ page(1).per(3) }

  scope :top_viewable_foods, ->{ foods.where( " show_top = ? ", true ) }

  # use batch
  # update recipe food genre count
  def self.aggrigation
    foods = Recipe.group(:recipe_food_id).count
    RecipeFoodGenre.all.each_with_index do |genre,idx|
      foods = genre.foods.select(:id)
      amount = Recipe.where( " recipe_food_id in (#{foods.to_sql}) " ).count
      genre.amount = amount
      genre.save
    end
  end

  # get food_genre use recipe_food_genre_id or recipe_food_id parameter
  def self.choice(params)
    # get recipe_food_genre_id
    food = nil
    food = RecipeFood.where( id: params[:recipe_food_id] ).first if params[:recipe_food_id]
    recipe_food_genre_id = (params[:recipe_food_genre_id] or food.try(:recipe_food_genre_id))
    genre = self
    genre = genre.where( id: recipe_food_genre_id ) if recipe_food_genre_id.present?
    genre.first
  end
end
