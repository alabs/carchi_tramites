FactoryGirl.define do

  factory :admin_user, class: AdminUser do
    email { generate(:email_seq) }
    password '123456789'
    password_confirmation '123456789'
  end

end
