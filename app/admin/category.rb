ActiveAdmin.register Category do

  permit_params :title

  menu parent: "Actividades"

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
    table_for category.events do
      column :id
      column :title do |event|
        link_to event.title, admin_event_path(event)
      end
    end
    active_admin_comments
  end

end
