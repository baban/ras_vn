class CreateToppageContents < ActiveRecord::Migration
  def change
    create_table :toppage_contents do |t|
      t.integer :recommend_recipe_id, null: false
      t.integer :recommend_recipe_genre_id, null: false

      t.timestamps
    end
  end
end
