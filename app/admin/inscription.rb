# FIXME: DRY app helpers inscriptions 
def get_locations(type, prefix)
  # :parroquias, "ins"
  # :parroquias, "rep"
  #Rails.cache.fetch("locations__#{prefix}_#{type}") do 
    result = File.open("db/geo/ecuador_#{type}.csv").read().split(/\n/)
    result = result.map { |n| n.split(',') }
    case type
    when :provincias
      result = result.map {|n| [ n[1], "c_#{prefix}provincia_#{n[0]}" ] }
    when :cantones
      result = result.map {|n| [ n[2], "c_#{prefix}canton_#{n[0]}_#{n[1]}", {'class': "sub_c_#{prefix}provincia_#{n[0]}"} ] }
    when :parroquias
      result = result.map {|n| [ n[3], "c_#{prefix}parroquia_#{n[0]}_#{n[1]}_#{n[2]}", {'class': "sub_c_#{prefix}canton_#{n[0]}_#{n[1]}"} ] }
    end
  #end
end

ActiveAdmin.register Inscription do

  permit_params :event_id, :first_name, :last_name, :email, :phone, :motive, :office, :document_id, :sex, :born_at, :address, :parroquia, :canton, :provincia, :admin_observation, :ed_level, :ed_unity, :observations, :rep_document_id, :rep_full_name, :rep_sex, :rep_title, :rep_phone_home, :rep_phone_celular, :rep_parroquia, :rep_canton, :rep_provincia, :rep_address, :rep_work_name, :rep_work_address, :rep_work_phone, :plant_location, :plant_representation

  filter :first_name
  filter :last_name
  filter :email
  filter :phone, as: :string
  filter :sex, as: :select, collection: Inscription::SEX.to_a
  filter :status, as: :select, collection: Inscription::STATUS.to_a
  filter :event, if:  proc { current_admin_user.admin? }
  filter :inscriptions_plants_plant_name, as: :select, collection: Plant.all, if: proc { current_admin_user.plantas? or current_admin_user.admin? }
  filter :appointed_at, if: proc { current_admin_user.audiencia? or current_admin_user.admin? }
  filter :created_at

  index do
    selectable_column
    column :full_name do |inscription|
      link_to inscription.full_name, admin_inscription_path(inscription)
    end
    if current_admin_user.actividad? or current_admin_user.admin?
      column :event
    end
    if current_admin_user.audiencia?
      column :appointed_at
      column :motivo do |inscription|
        dl do 
          dd "Motivo" 
          dt inscription.motive
        end
        if inscription.office?
          dl do 
            dd "Oficio" 
            dt inscription.office
          end
        end
      end
      column :contacto do |inscription|
        if inscription.email?
          dl do 
            dd "Email" 
            dt inscription.email
          end
        end
        if inscription.phone?
          dl do 
            dd "Teléfono" 
            dt inscription.phone
          end
        end
      end
    end
    column :status do |inscription|
      div inscription.status_name, class: inscription.status_class
    end
    actions
  end

  form do |f|
    f.inputs "Inscripción" do
      f.input :event
      f.input :document_id
      f.input :first_name
      f.input :last_name
      f.input :sex, as: :select, collection: Inscription::SEX.to_a
      f.input :born_at, as: :datepicker
      f.input :address, input_html: {rows: 2}
      f.input :provincia, as: :select, collection: get_locations(:provincias, "ins")
      f.input :canton, as: :select, collection: get_locations(:cantones, "ins")
      f.input :parroquia, as: :select, collection: get_locations(:parroquias, "ins")
      f.input :phone
      f.input :email
      if f.object.event and f.object.event.ttype_class == "actividad"
        f.input :ed_level
        f.input :ed_unity
        f.input :observations
        f.inputs "Datos de representante" do 
          f.input :rep_document_id
          f.input :rep_full_name
          f.input :rep_sex, as: :select, collection: Inscription::SEX.to_a
          f.input :rep_title
          f.input :rep_phone_home
          f.input :rep_phone_celular
          f.input :rep_provincia, get_locations(:provincias, "rep")
          f.input :rep_canton, get_locations(:cantones, "rep")
          f.input :rep_parroquia, get_locations(:parroquias, "rep")
          f.input :rep_address
          f.input :rep_work_name
          f.input :rep_work_address
          f.input :rep_work_phone
        end
      end
      if f.object.event and f.object.event.ttype_class == "plantas"
        # TODO: plantas with has_many 
        f.input :plant_location
        f.input :plant_representation
      end
    end
    f.actions
  end

  show do 
    if inscription.event.ttype_class == "audiencia"
      panel "Datos de la cita" do
        attributes_table_for inscription do
          row :motive
          row :office
          row :appointed_at 
        end
      end
    end
    attributes_table do
      row :id
      row :event
      row :full_name
      row :first_name
      row :last_name
      row :document_id
      row :sex
      row :born_at
      row :provincia_name
      row :canton_name
      row :parroquia_name
      row :address
      row :phone
      row :email do |inscription|
        mail_to inscription.email
      end
      row :created_at
      if inscription.event.ttype_class == "actividad"
        row :ed_level
        row :ed_unity
        row :observations
      end
      if inscription.event.ttype_class == "audiencia"
        row :appointed_at
      end
      row :admin_observation
    end
    if inscription.event.ttype_class == "actividad"
      panel "Datos del Representante" do
        attributes_table_for inscription do
          row :rep_document_id 
          row :rep_full_name
          row :rep_sex
          row :rep_title
          row :rep_phone_home
          row :rep_phone_celular
          row :rep_parroquia
          row :rep_canton
          row :rep_provincia
          row :rep_address
          row :rep_work_name
          row :rep_work_address
          row :rep_work_phone
        end
      end
    end
    if inscription.event.ttype_class == "plantas"
      panel "Plantas solicitadas" do
        attributes_table_for inscription do 
          row :plant_location
          row :plant_representation
        end
        table_for inscription.inscriptions_plants do 
          column "Especie", :plant do |ic_plant|
            span ic_plant.plant.name
          end
          column "Cantidad", :quantity
        end
      end
    end
    active_admin_comments
  end

  sidebar "Acciones pendientes", only: [:show, :edit] do
    if inscription.pending?
      span "Revisa la inscripción, estúdiala y comúnicate con el inscrito o su responsable legal y luego Aprueba o Rechaza la inscripción."
    end
    dl do
      dt "Estado"
      dd inscription.status_name, class: inscription.status_class
      if inscription.pending?
        dt "Acciones"
        dd link_to('Aprobar inscripción', observations_approve_admin_inscription_path(inscription), class: "button", method: :post, data: { confirm: "¿Estas segura de querer aprobar esta inscripción? Enviaremos un email confirmándole la inscripción." }) 
        br
        dd link_to('Rechazar inscripción', observations_deny_admin_inscription_path(inscription), class: "button button-danger", method: :post, data: { confirm: "¿Estas segura de querer rechazar esta inscripción? Enviaremos un email comúnicandole que su inscripción ha sido rechazada." }) 
      end
    end
  end

  # TODO: DRY observations
  member_action :observations_approve, :method => :post do
    @inscription = Inscription.find(params[:id])
  end

  member_action :observations_deny, :method => :post do
    @inscription = Inscription.find(params[:id])
  end

  member_action :approve, :method => :post do
    inscription = Inscription.find(params[:id])
    inscription.admin_observation = params[:inscription][:admin_observation]
    inscription.save
    inscription.approve!
    if inscription.email?
      InscriptionMailer.approved(inscription.id).deliver_now
      msg = "Hemos enviado un mail al usuario #{inscription.full_name} diciendole que ha sido aprobado."
    else
      msg = "NO hemos enviado un mail. Debes llamar al usuario #{inscription.full_name} diciendole que ha sido aprobado. Su número de teléfono es #{inscription.phone}."
    end
    flash[:notice] = msg
    redirect_to action: :index
  end

  member_action :deny, :method => :post do
    inscription = Inscription.find(params[:id])
    inscription.admin_observation = params[:inscription][:admin_observation]
    inscription.save
    inscription.deny!
    if inscription.email?
      InscriptionMailer.denied(inscription.id).deliver_now
      msg = "Hemos enviado un mail al usuario #{inscription.full_name} diciendole que ha sido rechazado."
    else
      msg = "NO hemos enviado un mail. Debes llamar al usuario #{inscription.full_name} diciendole que ha sido rechazado. Su número de teléfono es #{inscription.phone}."
    end
    flash[:notice] = msg
    redirect_to action: :index
  end

end
