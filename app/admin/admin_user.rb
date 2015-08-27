def flag_to_collection model, col
  model::flag_mapping[col.to_s].map do |k, v|
    [I18n.t(k, scope: "activerecord.attributes.#{model.to_s.tableize.singularize}.#{col.pluralize}"), v]
  end
end

ActiveAdmin.register AdminUser do

  menu parent: "Administración"

  permit_params :email, :password, :password_confirmation, roles_array: []

  show do 
    attributes_table do 
      row :email
      row :roles do 
        ul do
          li "Admin: #{ admin_user.admin? }"
          li "Sólo Plantas: #{ admin_user.plantas? }"
          li "Sólo Actividad: #{ admin_user.actividad? }"
          li "Sólo Audiencia: #{ admin_user.audiencia? }"
        end
      end
      "Para cambiar de contraseña ..."
    end
    active_admin_comments
  end

  index do
    selectable_column
    id_column
    column :email
    column :roles do |admin_user|
      ul do
        li "Admin: #{ admin_user.admin? }"
        li "Sólo Plantas: #{ admin_user.plantas? }"
        li "Sólo Actividad: #{ admin_user.actividad? }"
        li "Sólo Audiencia: #{ admin_user.audiencia? }"
      end
    end
    actions
  end

  form do |f|
    f.inputs "Detalles del Usuario" do
      f.input :email
      f.input :roles_array, as: :check_boxes, collection: flag_to_collection(AdminUser, 'roles')
    end
    f.actions
  end

end
