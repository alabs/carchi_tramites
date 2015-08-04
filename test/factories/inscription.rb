FactoryGirl.define do

  sequence :email_seq do |n|
    "foo#{n}@example.com"
  end

  factory :inscription do
    first_name "Jorge"
    last_name "Macanudo"
    phone "123456789"
    email { generate(:email_seq) }
    event
  end

end
