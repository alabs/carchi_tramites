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
    parroquia "Tulcán"
    canton "Carchi"
    provincia "Carchi"
    rep_document_id "1234567"
    rep_full_name "Jorge Macanudo Sr."
    rep_title "Padre"
    rep_sex 1
    rep_phone_home "12421414"
    rep_phone_celular "12421414"
    rep_parroquia "Tulcán"
    rep_canton "Carchi"
    rep_provincia "Carchi"
    rep_work_name "Fabrica"
    rep_work_address "Fabrica"
    rep_work_phone "12421414"
  end

end
