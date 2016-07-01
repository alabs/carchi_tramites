ActiveAdmin.register Instructor do

  menu parent: "Departamento: Casa de la Juventud"

  permit_params :document_id, :full_name, :born_at, :event_id, :title, :phone, :phone_home, :address, :sex

  before_filter :skip_sidebar!, :only => :index

  index do
    selectable_column
    id_column
    column :full_name
    column :event
    column :phone
    actions
  end

  show do
    attributes_table do
      row :document_id
      row :full_name
      row :born_at
      row :sex_name 
      row :event_id
      row :title
      row :phone
      row :phone_home
      row :address
    end
    active_admin_comments
  end

  form do |f|
    f.inputs "Instructor" do
      f.input :document_id
      f.input :full_name
      f.input :born_at, start_year: 1900
      f.input :sex, as: :select, collection: Inscription::SEX.to_a
      f.input :event
      f.input :title
      f.input :phone
      f.input :phone_home
      f.input :address
    end
    f.actions
  end

end

