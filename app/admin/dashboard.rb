ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel "Casa de la Juventud: Actividades" do
          render partial: "stats_wrapper", locals: { event_type: 1, context: self }
        end
      end
      column do
        panel "Prefectura: Audiencia con Prefecto" do
          render partial: "stats_wrapper", locals: { event_type: 2, context: self }
        end
      end
      column do
        panel "Medio Ambiente: reforestación de plantas" do
          render partial: "stats_wrapper", locals: { event_type: 3, context: self }
        end
      end
    end
    h2 "Inscripciones pendientes"
    columns do
      column do
        panel "Casa de la Juventud: Actividades" do
          render partial: "inscriptions_table", locals: { event_type: 1 }
        end
      end
      column do
        panel "Prefectura: Audiencia con Prefecto" do
          render partial: "inscriptions_table", locals: { event_type: 2 }
        end
      end
      column do
        panel "Medio Ambiente: reforestación de plantas" do
          render partial: "inscriptions_table", locals: { event_type: 3 }
        end
      end
    end # content
  end
end
