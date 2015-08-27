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
    document_id "1234567"
    sex 0
    born_at DateTime.now-18.years
    address "C/Inventada 123"
    parroquia "Parrish"
    canton "Catish"
    provincia "Carchi"
  end

end
