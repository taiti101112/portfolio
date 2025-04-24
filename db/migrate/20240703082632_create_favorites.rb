class CreateFavorites < ActiveRecord::Migration[6.0]
  def change
    create_table :favorites do |t|
      t.references :user, null: false, foreign_key: true
      t.references :shop, null: false, foreign_key: true
      t.timestamps
    end

    # インデックスが存在しない場合のみ作成する
    return if index_exists?(:favorites, %i[user_id shop_id], unique: true)

    add_index :favorites, %i[user_id shop_id], unique: true
  end
end
