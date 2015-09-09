role :app, %w{atencionciudadana.carchi.gob.ec}
role :web, %w{atencionciudadana.carchi.gob.ec}
role :db,  %w{atencionciudadana.carchi.gob.ec}

set :repo_url, 'git@github.com:alabs/carchi_tramites.git'
set :rvm_ruby_version, '2.2.2'
set :branch, :production
set :deploy_to, '/var/www/atencionciudadana.carchi.gob.ec'
