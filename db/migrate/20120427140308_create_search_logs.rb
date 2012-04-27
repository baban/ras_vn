class CreateSearchLogs < ActiveRecord::Migration
  def change
    create_table :search_logs do |t|
      t.user_id :integer,  null: false
      t.string  :words,    null: false, default: ""
      t.string  :location, null: false, default: ""

      t.timestamps
    end
  end
end
