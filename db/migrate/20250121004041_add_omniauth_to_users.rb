# frozen_string_literal: true

class AddOmniauthToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :provider, :string
    add_column :users, :uid, :string
    add_index :users, %i[provider uid], unique: true
  end
end
