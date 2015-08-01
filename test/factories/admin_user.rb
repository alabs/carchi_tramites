FactoryGirl.define do

  sequence :email do |n|
    "foo#{n}@example.com"
  end

  factory :admin_user, class: AdminUser do
    email
    email_confirmation { email }
    password '123456789'
  end

end

