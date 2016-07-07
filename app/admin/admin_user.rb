def human_boolean(boolean)
  boolean ? 'Sí' : 'No'
end

def flag_to_collection model, col
  model::flag_mapping[col.to_s].map do |k, v|
    [I18n.t(k, scope: "activerecord.attributes.#{model.to_s.tableize.singularize}.#{col.pluralize}_def"), v]
  end
end

ActiveAdmin.register AdminUser do

  #config.xls_builder.i18n_scope = [:activerecord, :attributes, :inscription]

  menu parent: "Administración"

  permit_params :email, :password, :password_confirmation, roles_array: []

  before_filter :skip_sidebar!, :only => :index

  show do 
    attributes_table do 
      row :email
      row :roles do 
        ul do
          li "Admin: #{ human_boolean admin_user.admin? }"
          li "Sólo Plantas: #{ human_boolean admin_user.plantas? }"
          li "Sólo Actividad: #{ human_boolean admin_user.actividad? }"
          li "Sólo Audiencia: #{ human_boolean admin_user.audiencia? }"
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
        li "Admin: #{ human_boolean admin_user.admin? }"
        li "Sólo Plantas: #{ human_boolean admin_user.plantas? }"
        li "Sólo Actividad: #{ human_boolean admin_user.actividad? }"
        li "Sólo Audiencia: #{ human_boolean admin_user.audiencia? }"
      end
    end
    actions
  end

  form do |f|
    f.inputs "Detalles del Usuario" do
      f.input :email
      if f.object.new_record?
        f.input :password
        f.input :password_confirmation
      end
      f.input :roles_array, as: :check_boxes, collection: flag_to_collection(AdminUser, 'roles')
    end
    unless f.object.new_record?
      f.inputs "Contraseña" do
        span "En caso de olvido de contraseña, el reseteo debe hacerlo el mismo usuario con este enlace:"
        span link_to("He olvidado mi contraseña", new_admin_user_password_path)
      end
    end
    f.actions
  end

end
