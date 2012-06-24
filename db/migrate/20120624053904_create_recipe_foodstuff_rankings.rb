class CreateRecipeFoodstuffRankings < ActiveRecord::Migration
  def change
    create_table :recipe_foodstuff_rankings do |t|
      t.integer :recipe_foodstuff_id

      t.timestamps
    end
  end
end
