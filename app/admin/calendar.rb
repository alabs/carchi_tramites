ActiveAdmin.register_page "Calendario" do

  menu parent: "Departamento: Prefectura"

  content do 
    panel "Ayuda" do
      "Calendario con citas para el Prefecto"
    end
    panel "Calendario" do
      columns do 
        column do
          render "index"
        end
      end
    end
  end

end
