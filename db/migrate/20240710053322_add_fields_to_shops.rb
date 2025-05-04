# frozen_string_literal: true

class AddFieldsToShops < ActiveRecord::Migration[7.0]
  def change
    add_column :shops, :twitter, :string
    add_column :shops, :instagram, :string
    add_column :shops, :official_hp, :string
  end
end
