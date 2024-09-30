class AddUserIdToShopsIfNotExists < ActiveRecord::Migration[7.0]
  def change
    unless column_exists?(:shops, :user_id)
      add_column :shops, :user_id, :integer
    end
  end
end
