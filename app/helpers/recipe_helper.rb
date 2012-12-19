# encoding: utf-8

module RecipeHelper
  def recipe_genre_select_area( f, option={} )
    food_genre_id = RecipeFood.where( id: option[:selected] ).first.try(:recipe_food_genre_id).to_i
    tag = select_tag(:recipe_genre_selecter, options_for_select(RecipeFoodGenre.all.map{ |o| [ o.name,o.id ] }, food_genre_id ) )
    tag<< '&nbsp;<span class="bet">/</span>&nbsp;'.html_safe
    tag<< f.grouped_collection_select(:recipe_food_id, RecipeFoodGenre.all, :recipe_foods, :name, :id, :name, option )
    tag.html_safe
  end
end
