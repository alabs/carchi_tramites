ActiveAdmin.register Category do

  permit_params :title

  #menu parent: "Actividades"

  index do
    selectable_column
    id_column
    column :title
    actions
  end

  show do
    attributes_table do
      row :id
      row :title
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

end
