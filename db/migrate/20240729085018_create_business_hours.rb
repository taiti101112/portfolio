# frozen_string_literal: true

class CreateBusinessHours < ActiveRecord::Migration[7.0]
  def change
    create_table :business_hours do |t|
      t.references :shop, null: false, foreign_key: true
      t.integer :day_of_week
      t.time :opening_time
      t.time :closing_time

      t.timestamps
    end
  end
end
