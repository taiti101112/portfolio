FactoryBot.define do
  factory :user do
    name { 'Test User' }
    email { Faker::Internet.unique.email }
    password { 'password' }
  end
end
