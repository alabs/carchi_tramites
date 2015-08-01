FactoryGirl.define do

  sequence :email_user do |n|
    "foo#{n}@example.com"
  end

  factory :admin_user, class: AdminUser do
    email { email_user }
    email_confirmation { email_user }
    password '123456789'
  end

end
