
# Descripción

Aplicación Ruby On Rails para tramites a medida del proyecto 3, subproyectos n 3.1 "Emisión de certificado de estar al corriente de pago con la Prefectura" y 3.4 "Calendario de actividades para jovenes (gestionada por Casa Juventud)".

# Instalación

```
git clone git@git.alabs.org:carchi/tramites.git
cd tramites
rvm install 2.2.2
bundle install
cp config/database.yml.example config/database.yml
cp config/secrets.yml.example config/secrets.yml
rake db:schema:load
rails server
```

# Funcionalidades

## 3.1.- Emisión de certificado de estar al corriente de pago con la Prefectura

     * Conexión el sistema que haga falta
    * El responsable técnico nos tiene que proporcionar la información de conexión
    * Si no se puede conectar, definir procedimiento:
      - Solicitud usuario por web.
      - Genera un correo-e al funcionario encargado de emitir certificado.
      - El funcionario comprueba si el solicitante esta al corriente o no.
      - En caso de que este al corriente el funcionario emite  el certificado de estar al coriente y le envia por correo-e al solicitante
      - En caso de que no este al corriente, el funcionaro emite un certificado de no estar el corriente y lo envia por mail al solicitante.
     * Disponer de una CA para emitir los certificados (Banco Central es el emisor)
     * La app debe guardar un registro (log) de todas las solicitude tramitdas.

## 3.4.- Calendario de actividades para jovenes

    * Que los jovenes se puedan solictar la inscripcion en las actividaes programadas
    Plantilla con listado de actividades
    Plantilla por actividad
    El usuario entra en actividad y hace click en "Solicito  participar"
    Rellena sus datos
    Genera Mail a funcionario Casa Juventud
    funcionario aprueba o deniega, con motivo
    Envia mail a usuario confirmando o denegando
    El funcionario puede ver un listado de personas apuntadas al curso
    El funcionario puede modificar los apuntados (sin que se genere mail).
