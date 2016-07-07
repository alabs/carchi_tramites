ActiveAdmin.register Event do

  #config.xls_builder.i18n_scope = [:activerecord, :attributes, :inscription]

  menu parent: "Administración"

  permit_params :title, :slug, :description, :admin_email, :ttype, :limit, :starts_at, :ends_at, :price

  before_filter :skip_sidebar!, :only => :index

  controller do
    def find_resource
      scoped_collection.friendly.find(params[:id])
    end
  end

  index do
    selectable_column
    id_column
    column :title
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
      row :slug
      row :description do |event|
        event.description.html_safe
      end
      row :admin_email
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
      #unless f.object.new_record?
      #  f.input :slug, hint: "URL que utilizará. No obligatorio, se genera automáticamente con el título. Una vez que se haya compartido y empezado a utilizar públicamente NO cambiar ya que generaría 'páginas no encontradas'."
      #end
      f.input :description, as: :ckeditor
      f.input :admin_email, hint: "Correo electrónico del administrador de la Categoría. Recibirá un correo electrónico al inscribirse un ciudadano nuevo. Pueden ser uno o varios. Formato: En el caso de ser varios 'foo1@example.com, foo2@example.com'."
      if current_admin_user.admin?
        f.input :ttype, as: :select, collection: Event::TYPE.to_a
      end
    end
    if current_admin_user.actividad? or current_admin_user.admin?
      f.inputs "Exclusivo Actividades de la Casa de la Juventud" do
        f.input :limit, hint: "Al alcanzar el límite de inscritos aprobados, se pondrá un aviso en el formulario de inscripción para nuevas inscripciones diciendo 'Este curso ha llegado al límite de inscritos aceptados, por lo que ya no hay más plazas disponibles. Puedes inscribirte y te contactaremos si hay alguna plaza disponible.'. Así mismo se mostrará un aviso en el Panel de Administración de este Evento y se enviará un correo electrónico al administrador de este Evento." 
        f.input :price, hint: "Precio que se pide para la asistencia a este curso." 
        f.input :starts_at, as: :datepicker, hint: "Fecha de inicio del curso."
        f.input :ends_at, as: :datepicker, hint: "Fecha de fin del curso."
      end
    end
    f.actions
  end

end
