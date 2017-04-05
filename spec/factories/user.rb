FactoryGirl.define do
  factory :user do
    provider 'email'
    email { FFaker::Internet.email }
    uid { FFaker::Internet.email }
    password { '12345678' }
  end
end