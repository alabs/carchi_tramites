namespace :carchi do 
  namespace :db do
    desc "[carchi] Importa los estudiantes de la base de datos Legacy de la Casa de la Juventud y ejecuta rake db:seed"
    task seed: :environment do 
      require 'import_students'
      init_all
      Rake::Task["db:seed"].invoke
    end
  end
end


