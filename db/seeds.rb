# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#

categories = []
emails = []

[ "Informática", "Danza contemporánea", "Danza tradicional y música andina ecuatoriana", "Prefectura", "Medio Ambiente"].each do |c|
  categories << Category.create(title: c)
end

categories.each do |c|
  em = Email.create(category: c, ttype: 0, subject: "Pendiente", body_html: "Tu petición esta pendiente", body_text: "Tu petición esta pendiente")
  debugger unless em.valid?
  emails << em
  emails << Email.create(category: c, ttype: 1, subject: "Aprobado", body_html: "Has sido aprobado", body_text: "Has sido aprobado")
  emails << Email.create(category: c, ttype: 2, subject: "Denegado", body_html: "Has sido denegado", body_text: "Has sido denegado")
end

c_0 = Category.find_by_title("Prefectura").id
c_1 = Category.find_by_title("Medio Ambiente").id
c_2 = Category.find_by_title("Danza tradicional y música andina ecuatoriana").id
c_3 = Category.find_by_title("Danza contemporánea").id
c_4 = Category.find_by_title("Informática").id

events = [
  { 
    title: "Solicitud a la dirección de Medio Ambiente de plantas autoctonas para reforestación",
    type: 3,
    category: c_1,
    description: "<p><b>Producto 3.3 - Solicitud a la dirección de Medio Ambiente de plantas autoctonas para reforestación</b></p>
    
    <p>En el siguiente formulario podrás solicitar a la dirección de Medio Ambiente de plantas autoctonas para reforestación. Aparte de los datos que se piden normalmente verás que tendrás que poner un texto con la planta que solicita y numero de plantas. Una vez tu petición sea realizada recibirás un correo electrónico como acuse de recibo. Una vez lo haya revisado un funcionario del Departamento de Medio Ambiente, estudiará la solicitud y procederá a aceptarla o denegarla. Recibirás un correo electrónico con el resultado.</p>
    
    <p>Por otro lado el funcionario tiene un panel de Administración donde puede ver todas las peticiones pendientes por resolver y aprobarlas o denegarlas.</p>",
  },
  { 
    title: "Petición de Audiencia con el Prefecto",
    category: c_0,
    type: 2,
    description: "<p><b>Producto 3.1.- Petición de Audiencia con el Prefecto</b></p>
    <p>
    En el siguiente formulario podrás solicitar la Petición de Audiencia con el Prefecto. Una vez tu petición sea realizada recibirás un correo electrónico como acuse de recibo. Una vez lo haya revisado la secretaria te enviaremos otro correo, confirmando o denegando la petición.
      </p>
    <p>
    Por otro lado el funcionario tiene un panel de Administración donde puede ver todas las peticiones pendientes por resolver y aprobarlas o denegarlas.
      </p>",
  },
  { 
    title: "Todos los días de 16:30 a 18:00 - Cuerpo de músicos del Ballet Juyungo",
    category: c_2,
    type: 1,
  },
  { 
    title: "Todos los días de 16:00 a 18:00 - 15 estudiantes", 
    category: c_2,
    type: 1,
  },
  { 
    title: "Todos los días de 15:00 a 17:00 - 17 estudiantes",
    type: 1,
    category: c_2,
  },
  { 
    title: "Todos los días de 17:30 a 19:00 - Jóvenes (nuevos y Avanzados)",
    type: 1,
    category: c_3,
  },
  { 
    title: "Todos los días de 16:15 a 17:30 - Niños y Niñas Avanzados 16",
    type: 1, 
    category: c_3,
  },
  { 
    title: "Todos los días de 15:00 a 16:15 - Niños y Niñas Nuevos 23",
    type: 1, 
    category: c_3,
  },
  { 
    title: "Viernes 15:00 a 18:00 - Prácticas de formación tecnológica",
    type: 1, 
    category: c_4,
  },
  { 
    title: "Jueves 15:00 a 17:00 - Proyectos juveniles",
    type: 1,
    category: c_4,
  },
  { 
    title: "Miércoles 15:00 a 17:00 - Proyectos juveniles",
    type: 1,
    category: c_4,
  },
  { 
    title: "Martes 17:00 a 19:00 - Informática Avanzada",
    type: 1,
    category: c_4,
  },
  { 
    title: "Jueves: 17:00 a 19:00 - Informática Básica a la Ciudadanía",
    type: 1, 
    category: c_4,
  },
  { 
    title: "Miércoles: 17:00 a 19:00 - Informática Básica a la Ciudadanía",
    type: 1, 
    category: c_4,
  },
  { 
    title: "Lunes 15:00 a 17:00 - Informática Básica a la Ciudadanía",
    type: 1, 
    category: c_4,
  },
]

events.each do |e|
  event = Event.create(category_id: e[:category], title: e[:title], ttype: e[:type], description: e.has_key?(:description) ? e[:description] : "BLA")
  debugger unless event.valid?
end

[ "aliso", "yahuar", "quishuar", "puma maqui", "pino", "ciprés", "eucalipto" ].each do |plant|
  Plant.create(name: plant)
end

