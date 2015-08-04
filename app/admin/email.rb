ActiveAdmin.register Email do

  permit_params :category_id, :ttype, :subject, :body_text, :body_html, :ttype

  #menu parent: "Actividades"

  filter :subject
  filter :body_text
  filter :body_html
  filter :category, as: :select, collection: Category.all
  filter :ttype, as: :select, collection: Email::TYPE.to_a

  index do
    selectable_column
    id_column
    column :subject
    column :category
    column :ttype_name
    actions
  end

  show do
    attributes_table do
      row :id
      row :category
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
      f.input :category, as: :select, collection: Category.all
      f.input :ttype, as: :select, collection: Email::TYPE.to_a
      f.input :subject
      f.input :body_text
      f.input :body_html
    end
    f.actions
  end

end
