
# Descripción

Aplicación Ruby On Rails para tramites a medida del proyecto 3, subproyectos n 3.1 "Emisión de certificado de estar al corriente de pago con la Prefectura" y 3.4 "Calendario de actividades para jovenes (gestionada por Casa Juventud)".

# Instalación de producción

Ver https://github.com/alabs/carchi_deploy

# Instalación de desarrollo

```
sudo apt-get install libqt4-dev          # capybara-webkit
sudo apt-get install libmysqlclient-dev  # mysql2

git clone https://github.com/alabs/carchi_tramites
cd carchi_tramites
rvm install 2.2.2
bundle install
cp config/database.yml.example config/database.yml
cp config/secrets.yml.example config/secrets.yml
rake db:schema:load
rake db:seed
```

# Servidor de desarrollo

Para comprobar los cambios en local, hace falta ejecutar el comando: 

```
rails server
```

Podremos visitar la web en http://localhost:3000

# Ejecución de tests

Para comprobar que todos los tests se ejecutan correctamente se puede ver con el comando: 
```
rake test 
```

Se puede ver en el sistema de Integración Continua (CI) 


[![Build Status](https://travis-ci.org/alabs/carchi_tramites.svg?branch=production)](https://travis-ci.org/alabs/carchi_tramites)

# Deploy 

Utilizamos capistrano para subir los cambios. Configurar en config/deploy.rb, config/deploy/staging.rb y config/deploy/production.rb. Subir cambios committeando a las ramas git production o staging y ejecutando:

``` 
cap staging deploy
cap production deploy
```
