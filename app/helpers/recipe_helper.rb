# encoding: utf-8

module RecipeHelper
  def recipe_genre_select_area(f)
    tag  = select_tag(:recipe_genre_selecter, options_for_select(RecipeFoodGenre.all.map{ |o| [ o.name,o.id ] }) )
    tag += f.grouped_collection_select(:recipe_food_id, RecipeFoodGenre.all, :recipe_foods, :name, :id, :name, include_blank: true )
    tag.html_safe
  end
end
