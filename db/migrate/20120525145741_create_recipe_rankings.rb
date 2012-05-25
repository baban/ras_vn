class CreateRecipeRankings < ActiveRecord::Migration
  def change
    create_table :recipe_rankings do |t|

      t.timestamps
    end
  end
end
