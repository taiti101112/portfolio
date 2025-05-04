# frozen_string_literal: true

class AddAdminToUsersIfNotExists < ActiveRecord::Migration[7.0]
  def change
    return if column_exists?(:users, :admin)

    add_column :users, :admin, :boolean, default: false, null: false
  end
end
