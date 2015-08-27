require "test_helper"

feature "Inscriptions" do 

  scenario "Working all right" do
    category = FactoryGirl.create(:category)
    event = FactoryGirl.create(:event, category: category)
    email = FactoryGirl.create(:email, :pending, category: category)
    visit root_path
    click_link "Ver actividades"
    click_link "Inscribirse"
    fill_in :inscription_document_id, with: "1245667890"
    fill_in :inscription_first_name, with: "Kevin"
    fill_in "Apellido", with: "García"
    fill_in :inscription_phone, with: "1245667890", match: :first
    fill_in "Correo electrónico", with: "hola@example.com"
    select "Hombre", from: :inscription_sex
    select "15", from: :inscription_born_at_3i
    select "septiembre", from: :inscription_born_at_2i
    select "1970", from: :inscription_born_at_1i
    fill_in :inscription_provincia, with: "Kevin"
    fill_in :inscription_canton, with: "Kevin"
    fill_in :inscription_parroquia, with: "Kevin"
    fill_in :inscription_address, with: "Kevin"
    click_button "Create Inscripción"
    page.must_have_content "Revisaremos tu inscripción y te avisaremos el resultado dentro de unos días."
  end

end
