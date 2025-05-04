# frozen_string_literal: true

FactoryBot.define do
  factory :shop do
    name { 'Test Shop' }
    address { '123 Main St' }
    user
  end
end
