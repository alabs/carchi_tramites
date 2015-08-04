FactoryGirl.define do

  factory :email do
    category
    ttype 0
    subject "Pendiente de respuesta para tu inscripción"
    body_html "Debemos revisarla y decirte algo"
    body_text "<b>Debemos revisarla y decirte algo</b>"
    trait :pending do
      ttype 0
      subject "Pendiente de respuesta para tu inscripción"
      body_html "Debemos revisarla y decirte algo"
      body_text "<b>Debemos revisarla y decirte algo</b>"
    end
    trait :approved do
      ttype 1
      subject "Aprobado"
      body_html "Aprobado"
      body_text "<b>Aprobado</b>"
    end
    trait :denied do
      ttype 2
      subject "Denegado"
      body_html "Denegado"
      body_text "<b>Denegado</b>"
    end
  end

end
