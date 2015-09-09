role :app, %w{beta.atencionciudadana.carchi.gob.ec}
role :web, %w{beta.atencionciudadana.carchi.gob.ec}
role :db,  %w{beta.atencionciudadana.carchi.gob.ec}

set :repo_url, 'git@github.com:alabs/carchi_tramites.git'
set :rvm_ruby_version, '2.2.2'
set :branch, :staging
set :deploy_to, '/var/www/beta.atencionciudadana.carchi.gob.ec'
