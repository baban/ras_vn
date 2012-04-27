class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.user_id :integer
      t.comment :text
      t.point :float

      t.timestamps
    end
  end
end
