ActiveAdmin.register Event do

  permit_params :title, :description, :category_id, :ttype

  #menu parent: "Actividades"

  filter :title
  filter :description
  filter :category
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
    attributes_table do
      row :id
      row :title
      row :description do |event|
        event.description.html_safe
      end
      row :category
    end
    table_for event.inscriptions do 
      column :full_name do |user|
        link_to user.full_name, admin_inscription_path(user)
      end
      column :phone
      column :email do |user|
        mail_to user.email
      end
      column :status do |user|
        span user.status_name, class: user.status_class
      end
    end
    active_admin_comments
  end

  form do |f|
    f.inputs "Evento" do
      f.input :title
      f.input :description
      f.input :ttype, as: :radio, collection: Event::TYPE.to_a
      f.input :category, as: :radio, collection: Category.all, label_html: { class: "js-event-category hide" }
    end
    panel "Ayuda" do
      ul do
        li do
          b "Certificado"
          span "- Emisión de certificado de estar al corriente de pago con la Prefectura"
        end
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
