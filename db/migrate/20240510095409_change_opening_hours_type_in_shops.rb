class ChangeOpeningHoursTypeInShops < ActiveRecord::Migration[7.0]
  def change
    change_column :shops, :opening_hours, :string
  end
end
