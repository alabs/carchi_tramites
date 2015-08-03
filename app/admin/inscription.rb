ActiveAdmin.register Inscription do

  permit_params :event_id, :first_name, :last_name, :email, :phone, :motive

  #menu parent: "Actividades"

  scope "Todas", :all, -> { all }

  scope "[estado] Pendiente", :pending
  scope "[estado] Aprobado", :approved
  scope "[estado] Denegado", :denied

  # custom scope not defined on the model
  scope("[tipo] Certificados") { |scope| scope.by_event_type(0) }
  scope("[tipo] Medio Ambiente") { |scope| scope.by_event_type(2) }
  scope("[tipo] Juventud") { |scope| scope.by_event_type(3) }

  filter :first_name
  filter :last_name
  filter :email
  filter :phone
  filter :status, as: :select, collection: Inscription::STATUS.to_a
  filter :event_category_id, label: "Categoría", as: :select, collection: Event::TYPE.to_a
  filter :event

  index do
    selectable_column
    id_column
    column :full_name
    column :category do |inscription|
      div inscription.event.category.title
    end
    column :event
    column :status do |inscription|
      div inscription.status_name, class: inscription.status_class
    end
    actions
  end

  form do |f|
    f.inputs "Inscripción" do
      f.input :event
      f.input :first_name
      f.input :last_name
      f.input :phone
      f.input :email
      if f.object.event and f.object.event.ttype_class == "plantas"
        f.input :motive, label: "Planta que solicita y numero de plantas"
      end
    end
    f.actions
  end

  show do 
    attributes_table do
      row :id
      row :event
      row :category do |inscription|
        inscription.event.category
      end
      row :full_name
      row :phone
      row :email do |inscription|
        mail_to inscription.email
      end
      row :created_at
      row :status_name do |inscription|
        dd inscription.status_name, class: inscription.status_class
      end
      row :actions do 
        if inscription.pending?
          span link_to('Aprobar inscripción', approve_admin_inscription_path(inscription), class: "button", method: :post, data: { confirm: "¿Estas segura de querer aprobar esta inscripción? Enviaremos un email confirmandole la inscripción." }) 
          span link_to('Rechazar inscripción', deny_admin_inscription_path(inscription), class: "button button-danger", method: :post, data: { confirm: "¿Estas segura de querer rechazar esta inscripción? Enviaremos un email comúnicandole que su inscripción ha sido rechazada." }) 
        end
      end
    end
    active_admin_comments
  end

  sidebar "Acciones pendientes", only: [:show, :edit] do
    dl do
      dt "Estado"
      dd inscription.status_name, class: inscription.status_class
      if inscription.pending?
        dt "Acciones"
        dd link_to('Aprobar inscripción', approve_admin_inscription_path(inscription), class: "button", method: :post, data: { confirm: "¿Estas segura de querer aprobar esta inscripción? Enviaremos un email confirmandole la inscripción." }) 
        br
        dd link_to('Rechazar inscripción', deny_admin_inscription_path(inscription), class: "button button-danger", method: :post, data: { confirm: "¿Estas segura de querer rechazar esta inscripción? Enviaremos un email comúnicandole que su inscripción ha sido rechazada." }) 
      end
    end
  end

  member_action :approve, :method => :post do
    inscription = Inscription.find(params[:id])
    inscription.approve!
    InscriptionMailer.approved(inscription.id).deliver_now
    flash[:notice] = "Hemos enviado un mail al usuario #{inscription.full_name} diciendole que ha sido aprobado."
    redirect_to action: :index
  end

  member_action :deny, :method => :post do
    inscription = Inscription.find(params[:id])
    inscription.deny!
    InscriptionMailer.denied(inscription.id).deliver_now
    flash[:notice] = "Hemos enviado un mail al usuario #{inscription.full_name} diciendole que ha sido rechazado."
    redirect_to action: :index
  end

end
