# encoding: utf-8

class AddSocialFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :uid, :integer
    add_column :users, :provider, :string
  end
end
