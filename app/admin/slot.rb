ActiveAdmin.register Slot do

  menu parent: "Departamento: Prefectura"

  permit_params :dow, :starts_hour, :ends_hour, :time

  before_filter :skip_sidebar!, :only => :index

  index do 
    panel "Ayuda" do
      "Calendario con citas para el Prefecto"
    end
    selectable_column
    id_column
    column :dow_name
    column :format_starts_hour
    column :format_ends_hour
    column :time do |slot|
      "#{slot.time} minutos"
    end
    actions
  end

  form do |f|
    f.inputs "Inscripción" do
      f.input :dow, as: :select, collection: Slot::DOW.to_a, hint: "Día de la semana"
      f.input :starts_hour, hint: "Hora en la que inicia. Formato: '0800'" 
      f.input :ends_hour, hint: "Hora en la que termina. Formato: '1600'"
      f.input :time, hint: "Tiempo que se corresponde en minutos. Formato: '30'"
    end
    f.actions
  end

  show do 
    attributes_table do
      row :id
      row :dow_name
      row :format_starts_hour
      row :format_ends_hour
    end
    active_admin_comments
  end

end
