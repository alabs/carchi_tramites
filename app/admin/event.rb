ActiveAdmin.register Event do

  permit_params :title, :category_id

  menu parent: "Actividades"

  index do
    selectable_column
    id_column
    column :title
    column :category
    actions
  end

  show do
    attributes_table do
      row :id
      row :title
      row :category
    end
    table_for event.inscriptions do 
      column :full_name do |user|
        link_to user.full_name, admin_inscription_path(user)
      end
      column :phone
      column :email do |user|
        mail_to user.email
      end
      column :status do |user|
        span user.status_name, class: user.status_class
      end
    end
    active_admin_comments
  end

end
