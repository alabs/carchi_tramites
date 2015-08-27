ActiveAdmin.register Category do

  menu parent: "Administración"

  permit_params :title, :admin_email

  before_filter :skip_sidebar!, :only => :index

  index do
    selectable_column
    id_column
    column :title
    column :admin_email
    actions
  end

  show do
    attributes_table do
      row :id
      row :title
      row :admin_email
    end
    panel "Emails" do
      table_for category.emails do
        column :id
        column "Asunto", :subject do |email|
          link_to email.subject, admin_email_path(email)
        end
        column "Tipo", :ttype_name
      end
    end
    panel "Eventos relacionados" do
      table_for category.events do
        column :id
        column "Título", :title do |event|
          link_to event.title, admin_event_path(event)
        end
      end
    end
    active_admin_comments
  end

  form do |f|
    f.inputs "Categoría" do
      f.input :title
      f.input :admin_email, hint: "Correo electrónico del administrador de la Categoría. Recibirá un correo electrónico al inscribirse un ciudadano nuevo. Pueden ser uno o varios. Formato: En el caso de ser varios 'foo1@example.com, foo2@example.com'. En el caso de ser una Actividad de la Casa de la Juventud con límites de inscritos, recibirá un correo electrónico al superarse."
    end
    f.actions
  end

end
