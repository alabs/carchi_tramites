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
      f.input :ttype, as: :select, collection: Event::TYPE.to_a, hint: "Tipo de evento.<br><b>Actividad</b>: Actividades de la Casa de la Juventud.<br><b>Audiencia</b>: Petición de Audiencia con el Prefecto.<br><b>Plantas</b>: Petición de Reforestación de Plantas (Medio Ambiente)."
      f.input :category, as: :select, collection: Category.all, label_html: { class: "js-event-category hide" }, hint: "Categoría del evento. En caso de ser Actividades de la Casa de la Juventud se pondrá su tipo de curso ('Informática', 'Danza Contemporánea', 'Danza Tradicional y Música Andina Ecuatoriana', etc), para la Petición de Reforestación de Plantas Autóctonas será 'Medio Ambiente' y para la Petición de Audiencia con el Prefecto será 'Prefectura'."
    end
    f.inputs "Exclusivo Actividades de la Casa de la Juventud" do
      f.input :limit, hint: "Al alcanzar el límite de inscritos aprobados, se pondrá un aviso en el formulario de inscripción para nuevas inscripciones diciendo 'Este curso ha llegado al límite de inscritos aceptados, por lo que ya no hay más plazas disponibles. Puedes inscribirte y te contactaremos si hay alguna plaza disponible.'. Así mismo se mostrará un aviso en el Panel de Administración de este Evento y se enviará un correo electrónico al administrador de este Evento." 
      f.input :price, hint: "Precio que se pide para la asistencia a este curso." 
      f.input :starts_at, as: :datepicker, hint: "Fecha de inicio del curso."
      f.input :ends_at, as: :datepicker, hint: "Fecha de fin del curso."
    end
    f.actions
  end

end
