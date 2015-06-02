FactoryGirl.define do
  factory :user do
    email {Faker::Internet.email}
    admin false
    password 12345678
    password_confirmation 12345678
  end
end
