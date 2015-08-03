FactoryGirl.define do

  factory :admin_user, class: AdminUser do
    email 
    password '123456789'
    password_confirmation '123456789'
  end

end
