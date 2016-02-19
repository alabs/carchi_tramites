[![Build Status](https://travis-ci.org/alabs/carchi_tramites.svg?branch=master)](https://travis-ci.org/alabs/carchi_tramites)

# Descripción

Aplicación Ruby On Rails para tramites a medida del proyecto 3, subproyectos n 3.1 "Emisión de certificado de estar al corriente de pago con la Prefectura" y 3.4 "Calendario de actividades para jovenes (gestionada por Casa Juventud)".

# Instalación de producción

Ver https://github.com/alabs/carchi_deploy

# Instalación de desarrollo

```
sudo apt-get install libqt4-dev          # capybara-webkit
sudo apt-get install libpq-dev           # postgres pg 

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


[![Build Status](https://travis-ci.org/alabs/carchi_tramites.svg?branch=master)](https://travis-ci.org/alabs/carchi_tramites)

# Deploy 

Utilizamos capistrano para subir los cambios. Configurar en config/deploy.rb, config/deploy/staging.rb y config/deploy/production.rb. Subir cambios committeando a las ramas git production o staging y ejecutando:

``` 
cap staging deploy
cap production deploy
```

# Base de Datos antigua (Legacy)

Para las Actividades de la Casa de la Juventud se parte de un sistema base ya creado con una base de datos, el SISTEMA DE INSCRIPCIÓN Y SEGUIMIENTO DE ESTUDIANTES (SISECJ), desarrollado por Ing. Xavier Narváez M. en PHP con base de datos PostgreSQL. 

Esta base de datos debe configurarse en el mismo servidor PostgreSQL en una base de datos diferente (denominada "legacy"). Se configurará dentro del fichero config/database.yml.

Se ha preparado la tarea para la importación inicial de datos: 

```
rake carchi:db:seed                           # [carchi] Importa los estudiantes de la base de datos Legacy de la Casa de la Juventud y ejecuta rake db:seed
```

# Integración con Google Calendar

Para el correcto funcionamiento del Google Calendar hace falta dar permisos en la cuenta de Google. Esto se realiza primero configurando una nueva aplicación en [Google Developers Console](https://console.developers.google.com/), habilitando la API de Google Calendar y creando las Credentials de acceso OAUTH2 del tipo Otro. Apuntaremos el Client ID y Secret de la aplicación.

También hay que conseguir el Calendar ID que se encuentra en la configuración del calendario de [Google Calendar](https://www.google.com/calendar/). 

Una vez tengamos estas tres claves las pondremos en nuestro config/secrets.yml 

```
  google_calendar: 
    client_id: changeme
    secret_key: changeme
    calendar_id: changeme
```

Por último para conseguir el valor del refresh_token debemos dar los permisos necesarios siguiendo las instrucciones de la tarea creada para ello.

```
rake carchi:google_calendar:refresh_token     # [carchi] Consigue el refresh_token inicial
```

Se ha hecho una tarea rake para poner en crontab con el fin de que la web no tenga retrasos para comprobar los slots disponibles en el Google Calendar, ya que generaba errores en el servidor. 

```
rake carchi:google_calendar:cache_slots
```

Más instrucciones y documentación de la librería: https://github.com/northworld/google_calendar
