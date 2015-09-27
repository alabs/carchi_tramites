ActiveAdmin.register Email do

  menu parent: "Administración"

  permit_params :event_id, :ttype, :subject, :body_text, :body_html, :ttype

  before_filter :skip_sidebar!, :only => :index

  index do
    selectable_column
    id_column
    column :subject
    column :event
    column :ttype_name
    actions
  end

  show do
    attributes_table do
      row :id
      row :event
      row :ttype_name
      row :subject
      row :body_text
      row :body_html do |email|
        email.body_html.html_safe
      end
    end
    active_admin_comments
  end

  form do |f|
    f.inputs "Email" do
      f.input :event, as: :select, collection: Event.all
      f.input :ttype, as: :select, collection: Email::TYPE.to_a
      f.input :subject, hint: "Asunto del email"
      f.input :body_text, hint: "Texto del mensaje, en formato texto plano"
      f.input :body_html, as: :ckeditor, hint: "Texto del mensaje, en formato HTML"
    end
    f.actions
  end

end
