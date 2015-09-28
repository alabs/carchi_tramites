

class LegacyDb < ActiveRecord::Base
  self.abstract_class = true
  establish_connection("legacy")
end

class LegacyInstructor < LegacyDb
  self.table_name= 'act_instructor'
end

class LegacyStudent < LegacyDb
  self.table_name= 'act_estudiante'
end

class LegacyRepresentant < LegacyDb
  self.table_name= 'act_representante'
end

def convert_sex(sex)
  res = { "FEMENINO": 0, "MASCULINO": 1, "SIN DETERMINAR": 2 }
  res[sex.to_sym]
end

def convert_date(date)
  if date
    Date.parse date.to_s 
  else 
    DateTime.now
  end
end

def convert_edunit(edunit)
  # "NO REGISTRA"
  Institute.find_or_create_by(title: edunit)
end

def convert_edtitle(edtitle)
  Inscription::ED_TITLE[edtitle]
end

def get_event(area)
  e = Event.find_by_title(area)
  unless e
    e = Event.new
    e.title = area
    e.ttype = 0
    e.description = "Actividad de la Casa de la Juventud"
    e.save
  end
  e
end

def process_all
  errors = [] 

  LegacyStudent.all.each do |s|

    # Estudiante
    i = Inscription.new
    i.last_name = s.apellido_estudiante 
    i.first_name = s.nombre_estudiante
    i.sex = convert_sex(s.sexo_estudiante)
    i.born_at = convert_date(s.fnacimiento_estudiante)
    i.phone = s.telefono_estudiante 
    i.address = s.direccion_estudiante
    i.parroquia = s.parroquia_estudiante
    i.canton = s.canton_estudiante
    i.provincia = s.provincia_estudiante
    i.document_id = s.id_estudiante
    i.ed_title = convert_edtitle s.educacion_estudiante 
    i.ed_level = s.curso_estudiante
    i.rep_full_name = s.representante_estudiante
    i.institute = convert_edunit(s.ueducativa_estudiante)
    i.event = get_event(s.area_formacion)
    i.observations = s.observaciones
    i.status = 1
    # s.estado_estudiante
    i.created_at = convert_date s.fi_estudiante

    # Representante 
    r = LegacyRepresentant.find_by_apnom_representante s.representante_estudiante
    debugger unless r
    errors << s.representante_estudiante unless r
    if r 
      i.rep_document_id = r.id_representante 
      i.rep_full_name = r.apnom_representante
      i.rep_sex = convert_sex r.sexo_representante 
      i.rep_title = r.titulo_representante 
      i.rep_phone_home = r.telefonod_representante 
      i.rep_phone_celular = r.telefonoc_representante
      i.rep_provincia = r.provincia_representante
      i.rep_canton = r.canton_representante
      i.rep_parroquia = r.parroquia_representante
      i.rep_address = r.direccion_representante
      i.rep_work_name = r.empresa_representante
      i.rep_work_address = r.diremp_representante
      i.rep_work_phone = r.telemp_representante
    end 
    i.save
    debugger if i.errors.count > 0 
  end

  LegacyInstructor.all.each do |l|
    i = Instructor.new
    i.document_id = l.id_instructor
    i.full_name = l.nombresc_instructor
    i.born_at = convert_date l.fnacimiento_instructor
    i.sex = convert_sex l.sexo_instructor
    i.event = get_event l.area_instructor
    i.title = l.titulo_instructor
    i.phone = l.telefono_instructor
    i.address = l.direccion_instructor
    i.phone_home = l.teldir_instructor
    i.save
  end

end

#namespace :carchi do 
#  namespace :legacy do
#    desc "[carchi] Importa los estudiantes de la base de datos Legacy de la Casa de la Juventud"
#    task check_limits: :environment do 
#      process_all
#    end
#  end
#end
#


Inscription.delete_all
Instructor.delete_all
Institute.delete_all
Email.delete_all
Event.delete_all
process_all

puts errors.count
