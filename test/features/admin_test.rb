require "test_helper"

feature "Admin" do 

  scenario "Admin without a Role and changing Roles" do

    user = FactoryGirl.create(:admin_user)
    visit admin_root_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "iniciar sesión"
    page.must_have_content "No tienes permiso para acceder a ninguna sección. Avisale a algún usuario Administrador para que te los asigne. "

    user.plantas = true
    user.save
    click_link "Inicio"
    page.wont_have_content "Prefectura: Audiencia con Prefecto"
    page.wont_have_content "Casa de la Juventud: Actividades"
    page.must_have_content "Medio Ambiente: reforestación de plantas"
    page.must_have_content "Inicio"
    page.must_have_content "todos"
    page.must_have_content "7 días"
    page.must_have_content "Pendientes"

    user.plantas = false
    user.audiencia = true
    user.save
    click_link "Inicio"
    page.must_have_content "Prefectura: Audiencia con Prefecto"
    page.wont_have_content "Medio Ambiente: reforestación de plantas"
    page.wont_have_content "Casa de la Juventud: Actividades"

    user.audiencia = false
    user.actividad = true
    user.save
    click_link "Inicio"
    page.wont_have_content "Prefectura: Audiencia con Prefecto"
    page.wont_have_content "Medio Ambiente: reforestación de plantas"
    page.must_have_content "Casa de la Juventud: Actividades"

    user.actividad = false
    user.admin = true
    user.save
    click_link "Inicio"
    page.must_have_content "Prefectura: Audiencia con Prefecto"
    page.must_have_content "Medio Ambiente: reforestación de plantas"
    page.must_have_content "Casa de la Juventud: Actividades"

  end

end
