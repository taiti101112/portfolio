# frozen_string_literal: true

class AddAddressInfoToShops < ActiveRecord::Migration[7.0]
  def change
    add_column :shops, :latitude, :float
    add_column :shops, :longitude, :float
  end
end
