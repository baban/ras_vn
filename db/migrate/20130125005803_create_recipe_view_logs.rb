class CreateRecipeViewLogs < ActiveRecord::Migration
  def change
    create_table :recipe_view_logs do |t|

      t.timestamps
    end
  end
end
