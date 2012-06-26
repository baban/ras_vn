class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :provider, :null => false
      t.string :uid, :null => false
      t.string :name, :null => false
      t.string :url_name
      t.string :email, :null => false
      t.text :description
      t.string :image
      t.string :token, :null => false
      t.string :token_secret
      t.timestamps
    end

    add_index :users, :uid, :name => "uid"
    add_index :users, :url_name, :name => "url_name"
  end
end
