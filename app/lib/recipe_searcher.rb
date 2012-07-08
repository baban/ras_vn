# encoding: utf-8

module RecipeSearcher
  def self.search( option={} )
    recipes = ->{
      if option[:recipe_food_id]
        self.search_by_recipe_food_id(option[:recipe_food_id]) 
      elsif option[:recipe_food_genre_id]
        self.search_by_recipe_food_genre_id(option[:recipe_food_genre_id])
      elsif option[:word]
        self.search_by_word(option[:word])
      else
        Recipe
      end      
    }.call
    page = option[:page] || 1
    recipes.page(page).per(12)
  end

  def self.search_by_recipe_food_id( recipe_food_id )
    recipe_ids = RecipeFoodstuff.where( " recipe_food_id = ? ", recipe_food_id ).pluck(:recipe_id)
    Recipe.where( " id in (?) ", recipe_ids )
  end

  def self.search_by_recipe_food_genre_id( recipe_food_genre_id )
    food_ids = RecipeFoodGenre.where( " id = ? ", recipe_food_genre_id ).pluck(:id)
    recipe_ids = RecipeFoodstuff.where( " recipe_food_id = ? ", food_ids ).pluck(:recipe_id)
    Recipe.where( " id in (?) ", recipe_ids )
  end

  def self.search_by_word( word )
    Recipe.where( " title like '%#{word}%' " )
  end
end
