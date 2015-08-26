ActiveAdmin.register_page "Calendar" do
  content do 
    panel "Calendario" do
      columns do 
        column do
          render "index"
        end
      end
    end
  end
end

