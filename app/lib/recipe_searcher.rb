# encoding: utf-8

module RecipeSearcher
  # TODO: 内部実装
  def self.search( option={} )
    page = option[:page] || 1
    recipes = Recipe
    #
    recipes = self.search_by_recipe_food_id(option[:recipe_food_id]) if option[:recipe_food_id]
    recipes = self.search_by_recipe_food_genre_id(option[:recipe_food_genre_id]) if option[:recipe_food_genre_id]
    
    recipes.page(page).per(12)
  end

  def self.search_by_recipe_food_id( recipe_food_id )
    recipe_ids = RecipeFoodstuff.where( " recipe_food_id = ? ", recipe_food_id ).pluck(:recipe_id)
    Recipe.where( " id in (?) ", recipe_ids )
  end

  def self.search_by_recipe_food_genre_id( recipe_food_genre_id )
    #food_grenes = 
    #recipe_ids = RecipeFoodstuff.where( " recipe_food_id = ? ", recipe_food_id ).pluck(:recipe_id)
    #Recipe.where( " id in (?) ", recipe_ids )
  end
end
