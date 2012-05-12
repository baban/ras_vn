class CreateRecipeGenreMasters < ActiveRecord::Migration
  def change
    create_table :recipe_genre_masters do |t|
      t.string :name

      t.timestamps
    end
  end
end
