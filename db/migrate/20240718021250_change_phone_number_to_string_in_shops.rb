# frozen_string_literal: true

class ChangePhoneNumberToStringInShops < ActiveRecord::Migration[7.0]
  def change
    change_column :shops, :phone_number, :string
  end
end
