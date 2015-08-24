
# Descripción

Aplicación Ruby On Rails para tramites a medida del proyecto 3, subproyectos n 3.1 "Emisión de certificado de estar al corriente de pago con la Prefectura" y 3.4 "Calendario de actividades para jovenes (gestionada por Casa Juventud)".

# Instalación

```
sudo apt-get install libqt4-dev          # capybara-webkit
sudo apt-get install libmysqlclient-dev  # mysql2

git clone git@git.alabs.org:carchi/tramites.git
cd tramites
rvm install 2.2.2
bundle install
cp config/database.yml.example config/database.yml
cp config/secrets.yml.example config/secrets.yml
rake db:schema:load
rake db:seed
rails server
```
