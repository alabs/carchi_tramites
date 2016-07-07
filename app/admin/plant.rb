ActiveAdmin.register Plant do

  #config.xls_builder.i18n_scope = [:activerecord, :attributes, :inscription]

  menu parent: "Departamento: Gestión Ambiental"

  permit_params :name, :active

  before_filter :skip_sidebar!, :only => :index

  index do
    panel "Ayuda" do
      "Aquí puedes encontrar las plantas que aparecerán en el desplegable al pedir Plantas para Reforestación"
    end
    selectable_column
    id_column
    column :name
    column :active
    actions
  end

end
