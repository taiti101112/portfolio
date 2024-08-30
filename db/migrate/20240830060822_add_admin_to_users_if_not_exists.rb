class AddAdminToUsersIfNotExists < ActiveRecord::Migration[7.0]
  def change
    unless column_exists?(:users, :admin)
      add_column :users, :admin, :boolean, default: false, null: false
    end
  end
end
