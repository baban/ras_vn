class CreateRecipeGoodLogs < ActiveRecord::Migration
  def change
    create_table :recipe_good_logs do |t|
      t.integer :user_id
      t.integer :recipe_id

      t.timestamps
    end
  end
end
