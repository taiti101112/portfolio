# frozen_string_literal: true

class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :shop
  validates :user_id, uniqueness: { scope: :shop_id }
end
