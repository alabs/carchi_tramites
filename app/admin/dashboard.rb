ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    # Here is an example of a simple dashboard with columns and panels.
    #
    columns do
      column do
        panel "Actividades: Inscripciones pendientes para revisar" do
          ul do
            Inscription.pending.map do |inscription|
              li link_to(inscription.full_name, admin_inscription_path(inscription))
            end
          end
        end
      end
      column do
        panel "Certificados: Inscripciones pendientes para revisar" do
          div "TODO"
        end
      end
    end
  end # content
end
