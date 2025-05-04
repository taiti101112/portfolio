# frozen_string_literal: true

json.extract! shop, :id, :name, :address, :phone_number, :duel_space_available, :opening_hours, :created_at, :updated_at
json.url shop_url(shop, format: :json)
