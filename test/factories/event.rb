FactoryGirl.define do

  factory :event do
    title "Miércoles: 17:00 a 19:00 - Informática Básica a la Ciudadanía"
    description "Hola mundo!"
    category
    ttype 1

    trait :actividad do
      ttype 1
    end
    trait :audiencia do
      ttype 2
    end
    trait :plantas do
      ttype 3
    end

  end

end
