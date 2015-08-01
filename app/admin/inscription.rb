ActiveAdmin.register Inscription do

  permit_params :event, :first_name, :last_name, :email, :phone

  menu parent: "Actividades"

  scope :pending
  scope :approved
  scope :denied

  index do
    selectable_column
    id_column
    column :full_name
    column :phone
    column :email do |user|
      mail_to user.email
    end
    column :event
    column :status do |user|
      div user.status_name, class: user.status_class
    end
    actions
  end

  show do 
    attributes_table do
      row :id
      row :event
      row :category do |user|
        user.event.category
      end
      row :full_name
      row :phone
      row :email do |user|
        mail_to user.email
      end
      row :created_at
      row :status_name do |user|
        div user.status_name, class: user.status_class
      end
      row :actions do 
        if inscription.pending?
          span link_to('Aprobar inscripción', approve_admin_inscription_path(inscription), class: "button", method: :post, data: { confirm: "¿Estas segura de querer aprobar esta inscripción? Enviaremos un email confirmandole la inscripción." }) 
          span link_to('Rechazar inscripción', deny_admin_inscription_path(inscription), class: "button", method: :post, data: { confirm: "¿Estas segura de querer rechazar esta inscripción? Enviaremos un email comúnicandole que su inscripción ha sido rechazada." }) 
        end
      end
    end
    active_admin_comments
  end

  member_action :approve, :method => :post do
    inscription = Inscription.find(params[:id])
    inscription.approve!
    InscriptionMailer.approved(inscription).deliver_now
    flash[:notice] = "Hemos enviado un mail al usuario #{inscription.full_name} diciendole que ha sido aprobado."
    redirect_to action: :index
  end

  member_action :deny, :method => :post do
    inscription = Inscription.find(params[:id])
    inscription.deny!
    InscriptionMailer.denied(inscription).deliver_now
    flash[:notice] = "Hemos enviado un mail al usuario #{inscription.full_name} diciendole que ha sido rechazado."
    redirect_to action: :index
  end

end
