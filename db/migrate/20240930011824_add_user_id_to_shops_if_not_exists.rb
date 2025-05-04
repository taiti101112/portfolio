# frozen_string_literal: true

class AddUserIdToShopsIfNotExists < ActiveRecord::Migration[7.0]
  def change
    return if column_exists?(:shops, :user_id)

    add_column :shops, :user_id, :integer
  end
end
