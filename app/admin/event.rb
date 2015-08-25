ActiveAdmin.register Event do

  permit_params :title, :description, :category_id, :ttype, :limit, :starts_at, :ends_at, :price

  #menu parent: "Actividades"

  filter :title
  filter :description
  filter :category
  filter :price
  filter :limit
  filter :starts_at
  filter :ends_at
  filter :ttype, as: :select, collection: Event::TYPE.to_a

  index do
    selectable_column
    id_column
    column :title
    column :category
    column :ttype_name
    actions
  end

  show do
    if event.limit and event.has_reached_limit? 
      panel "Alerta" do 
        status_tag "Ha llegado al límite de #{event.limit} inscritos", :error
        status_tag "Puedes aumentar el límite de inscritos editando este evento. En caso de que haya alguna plaza vacante puedes revisar en los usuarios que tengan inscripción pendiente. ", :error
      end
    end
    attributes_table do
      row :id
      row :title
      row :description do |event|
        event.description.html_safe
      end
      row :category
      if event.ttype_class == "actividad"
        row :price
        row :limit
        row :ends_at
        row :starts_at
      end
    end
    panel "Todas las Inscripciones" do 
      if event.inscriptions.count > 0
        table_for event.inscriptions do 
          column "Nombre completo", :full_name do |inscription|
            link_to inscription.full_name, admin_inscription_path(inscription)
          end
          column "Teléfono", :phone
          column "Correo electrónico", :email do |inscription|
            mail_to inscription.email
          end
          column "Fecha de creación", :created_at
          column "Estado", :status do |inscription|
            span inscription.status_name, class: inscription.status_class
          end
        end
      else
        span "No hay inscripciones a este evento"
      end
    end
    active_admin_comments
  end

  form do |f|
    f.inputs "Evento" do
      f.input :title
      f.input :description, as: :ckeditor
      f.input :limit
      f.input :price
      f.input :starts_at, as: :datepicker
      f.input :ends_at, as: :datepicker
      f.input :ttype, as: :radio, collection: Event::TYPE.to_a
      f.input :category, as: :radio, collection: Category.all, label_html: { class: "js-event-category hide" }
    end
    panel "Ayuda" do
      ul do
        li do
          b "Actividad"
          span "- Calendario de actividades para jovenes (gestionada por Casa Juventud)"
        end
        li do
          b "Audiencia"
          span "- Petición de audiencia con autoridades (Prefecto y Viceprefecta)"
        end
        li do
          b "Plantas"
          span "- Solicitud a la dirección de Medio Ambiente de plantas autoctonas para reforestación"
        end
      end
    end
    f.actions
  end

end
