require 'test_helper'

feature 'Inscriptions' do

  scenario 'Working all right' do
    event = FactoryGirl.create(:event, :plantas)
    visit medio_ambiente_path
    fill_in :inscription_document_id, with: '1245667890'
    fill_in :inscription_first_name, with: 'Kevin'
    fill_in 'Apellido', with: 'García'
    fill_in :inscription_phone, with: '1245667890', match: :first
    fill_in 'Correo electrónico', with: 'hola@example.com'
    select 'Hombre', from: :inscription_sex
    select '15', from: :inscription_born_at_3i
    select 'septiembre', from: :inscription_born_at_2i
    select '1970', from: :inscription_born_at_1i
    select 'Azuay', from: :inscription_provincia
    select 'Cuenca', from: :inscription_canton
    select 'Cuenca', from: :inscription_parroquia
    fill_in :inscription_address, with: 'Kevin'
    click_button 'Dar de alta inscripción'
    message = 'Revisaremos tu inscripción y te avisaremos el resultado en breve.'
    page.must_have_content message
  end
end
