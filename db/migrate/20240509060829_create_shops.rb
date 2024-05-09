class CreateShops < ActiveRecord::Migration[7.0]
  def change
    create_table :shops do |t|
      t.string :name
      t.string :address
      t.integer :phone_number
      t.integer :duel_space_available
      t.string :opening_hours

      t.timestamps
    end
  end
end
