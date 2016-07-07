ActiveAdmin.register Institute do

  #config.xls_builder.i18n_scope = [:activerecord, :attributes, :inscription]

  menu parent: "Departamento: Casa de la Juventud"

  permit_params :title, :principal_name, :phone, :address, :parroquia, :canton, :provincia, :foundated_at, :ttype, :students_number

  before_filter :skip_sidebar!, :only => :index

  index do
    selectable_column
    id_column
    column :title
    column :principal_name
    column :phone
    column :address
    actions
  end

  show do
    attributes_table do
      row :title
      row :principal_name
      row :phone
      row :address
      row :parroquia
      row :canton
      row :provincia
      row :foundated_at
      row :ttype_name
      row :students_number
    end
    active_admin_comments
  end

  form do |f|
    f.inputs "Unidad Educativa" do
      f.input :title
      f.input :principal_name
      f.input :phone
      f.input :address
      f.input :parroquia
      f.input :canton
      f.input :provincia
      f.input :foundated_at, start_year: 1900
      f.input :ttype, as: :select, collection: Institute::TYPE.to_a
      f.input :students_number
    end
    f.actions
  end

end
