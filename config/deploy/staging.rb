role :app, %w{capistrano@tramites.alabs.org}
role :web, %w{capistrano@tramites.alabs.org}
role :db,  %w{capistrano@tramites.alabs.org}

set :rvm_ruby_version, '2.2.2'
set :repo_url, 'git@git.alabs.org:carchi/tramites.git'
set :branch, :staging
set :deploy_to, '/var/www/tramites.alabs.org'

