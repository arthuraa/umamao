Factory.sequence(:email) { |n|
  "r#{n}@example.com"
}

FactoryGirl.define do
  factory :user do
    name
    password 'test1234'
    password_confirmation 'test1234'
    confirmed_at Time.now
    has_been_through_wizard true
    agrees_with_terms_of_service true
    email
  end
end
