require "test_helper"

feature "Inscriptions" do 

  scenario "Working all right" do
    category = FactoryGirl.create(:category)
    event = FactoryGirl.create(:event)
    visit root_path
    click_link "Inscribirse"
    fill_in "Nombre", with: "Kevin"
    fill_in "Apellido", with: "García"
    fill_in "Teléfono", with: "1245667890"
    fill_in "Correo electrónico", with: "hola@example.com"
    click_button "Crear Inscripción"
    page.must_have_content "Te has dado de alta en el curso. Revisaremos tu inscripción y te avisaremos el resultado dentro de unos días."
  end

end
