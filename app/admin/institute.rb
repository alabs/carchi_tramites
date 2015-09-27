ActiveAdmin.register Institute do

  menu parent: "Departamento: Casa de la Juventud"

  permit_params :title

  before_filter :skip_sidebar!, :only => :index

  index do
    selectable_column
    id_column
    column :title
    actions
  end

  show do
    attributes_table do
      row :title
    end
    active_admin_comments
  end

end
