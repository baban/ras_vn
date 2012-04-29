class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :user_id, null: false, default: 0
      t.text    :comment, null: true
      t.float   :point,   null: false, default: 0

      t.timestamps
    end
  end
end
