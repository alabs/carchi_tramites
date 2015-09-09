ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    unless current_admin_user.is? :actividad or current_admin_user.is? :admin or current_admin_user.is? :audiencia or current_admin_user.is? :plantas
      columns do 
        column do 
          panel "Error" do 
            render partial: "not_authorized" 
          end
        end
      end
    end
    if current_admin_user.is? :actividad or current_admin_user.is? :admin or current_admin_user.is? :audiencia or current_admin_user.is? :plantas
      columns do
        if current_admin_user.is? :actividad or current_admin_user.is? :admin
          column do
            panel "Casa de la Juventud: Actividades" do
              render partial: "stats_wrapper", locals: { event_type: 1, context: self }
            end
          end
        end
        if current_admin_user.is? :audiencia or current_admin_user.is? :admin
          column do
            panel "Prefectura: Audiencia con Prefecto" do
              render partial: "stats_wrapper", locals: { event_type: 2, context: self }
            end
          end
        end
        if current_admin_user.is? :plantas or current_admin_user.is? :admin
          column do
            panel "Gestión Ambiental: reforestación de plantas" do
              render partial: "stats_wrapper", locals: { event_type: 3, context: self }
            end
          end
        end
      end
      h2 "Inscripciones pendientes"
      if current_admin_user.is? :actividad or current_admin_user.is? :admin
        columns do
          column do
            panel "Casa de la Juventud: Actividades" do
              render partial: "inscriptions_table", locals: { event_type: 1 }
            end
          end
        end
      end
      if current_admin_user.is? :audiencia or current_admin_user.is? :admin
        columns do
          column do
            panel "Prefectura: Audiencia con Prefecto" do
              render partial: "inscriptions_table", locals: { event_type: 2 }
            end
          end
        end
      end
      if current_admin_user.is? :plantas or current_admin_user.is? :admin
        columns do
          column do
            panel "Gestión Ambiental: reforestación de plantas" do
              render partial: "inscriptions_table", locals: { event_type: 3 }
            end
          end
        end
      end # content
    end
  end
end
