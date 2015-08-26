ActiveAdmin.register Slot do

  before_filter :skip_sidebar!, :only => :index

  form do |f|
    f.inputs "Inscripción" do
      f.input :dow, as: :select, collection: Slot::DOW.to_a, hint: "Día de la semana"
      f.input :starts_hour, "Hora en la que inicia. Formato: '0800'" 
      f.input :ends_hour, "Hora en la que termina. Formato: '1600'"
      f.input :time, "Tiempo que se corresponde en minutos. Formato: '30'"
    end
    f.actions
  end

  show do 
    attributes_table do
      row :id
      row :dow_name
      row :starts_hour
      row :ends_hour
    end
    active_admin_comments
  end

end
