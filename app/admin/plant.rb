ActiveAdmin.register Plant do

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
