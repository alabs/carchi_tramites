require "test_helper"

feature "Admin" do 

  scenario "Working all right" do
    user = FactoryGirl.create(:admin_user)
    visit admin_root_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "iniciar sesión"
    save_and_open_page
    page.must_have_content "Inicio"
    page.must_have_content "todos"
    page.must_have_content "7 días"
    page.must_have_content "Pendientes"
  end

end
