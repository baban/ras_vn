class CreateRecipeLikeLogs < ActiveRecord::Migration
  def change
    create_table :recipe_like_logs do |t|
      t.integer :recipe_id
      t.integer :user_id

      t.timestamps
    end
  end
end
