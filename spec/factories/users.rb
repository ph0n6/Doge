FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "haitran#{n}" }
    sequence(:email) { |n| "haitran#{n}@gmail.com" }
    password '123456'
    password_confirmation '123456'
  end
end