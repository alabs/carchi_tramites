# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#


events = [
  { 
    title: "Solicitud a la dirección de Gestion Ambiental de plantas autoctonas para reforestación",
    type: 3,
    description: "<p><b>Producto 3.3 - Solicitud a la dirección de Gestion Ambiental de plantas autoctonas para reforestación</b></p>
    
    <p>En el siguiente formulario podrás solicitar a la dirección de Medio Ambiente de plantas autoctonas para reforestación. Aparte de los datos que se piden normalmente verás que tendrás que poner un texto con la planta que solicita y numero de plantas. Una vez tu petición sea realizada recibirás un correo electrónico como acuse de recibo. Una vez lo haya revisado un funcionario del Departamento de Medio Ambiente, estudiará la solicitud y procederá a aceptarla o denegarla. Recibirás un correo electrónico con el resultado.</p>
    
    <p>Por otro lado el funcionario tiene un panel de Administración donde puede ver todas las peticiones pendientes por resolver y aprobarlas o denegarlas.</p>",
  },
  { 
    title: "Petición de Audiencia con el Prefecto",
    type: 2,
    description: "<p><b>Producto 3.1.- Petición de Audiencia con el Prefecto</b></p>
    <p>
    En el siguiente formulario podrás solicitar la Petición de Audiencia con el Prefecto. Una vez tu petición sea realizada recibirás un correo electrónico como acuse de recibo. Una vez lo haya revisado la secretaria te enviaremos otro correo, confirmando o denegando la petición.
      </p>
    <p>
    Por otro lado el funcionario tiene un panel de Administración donde puede ver todas las peticiones pendientes por resolver y aprobarlas o denegarlas.
      </p>",
  },
]

events.each do |e|
  event = Event.create(title: e[:title], ttype: e[:type], description: e.has_key?(:description) ? e[:description] : "BLA")
end

Event.all.each do |event|
  Email.create(event: event, ttype: 0, subject: "Pendiente", body_html: "Tu petición esta pendiente", body_text: "Tu petición esta pendiente")
  Email.create(event: event, ttype: 1, subject: "Aprobado", body_html: "Has sido aprobado", body_text: "Has sido aprobado")
  Email.create(event: event, ttype: 2, subject: "Denegado", body_html: "Has sido denegado", body_text: "Has sido denegado")
end

[ "Aliso", "Yahuar", "Quishuar", "Puma maqui", "Pino", "Ciprés", "Eucalipto" ].each do |plant|
  Plant.create(name: plant, active: true)
end

Slot.create(dow: 1, starts_hour: "0800", ends_hour: "1600", time: "30")
Slot.create(dow: 3, starts_hour: "0800", ends_hour: "1600", time: "30")
