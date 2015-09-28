

class LegacyDb < ActiveRecord::Base
  self.abstract_class = true
  establish_connection(:legacy)
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
    e.ttype = 1
    e.description = "Actividad de la Casa de la Juventud"
    e.save
  end
  e
end

def process_all
  LegacyStudent.all.each do |s|

    # Estudiante
    i = Inscription.new
    i.last_name = s.apellido_estudiante.mb_chars.titleize 
    i.first_name = s.nombre_estudiante.mb_chars.titleize
    i.sex = convert_sex(s.sexo_estudiante)
    i.born_at = convert_date(s.fnacimiento_estudiante)
    i.phone = s.telefono_estudiante 
    i.address = s.direccion_estudiante.mb_chars.titleize
    i.parroquia = s.parroquia_estudiante.mb_chars.titleize
    i.canton = s.canton_estudiante.mb_chars.titleize
    i.provincia = s.provincia_estudiante.mb_chars.titleize
    i.document_id = s.id_estudiante
    i.ed_title = convert_edtitle s.educacion_estudiante 
    i.ed_level = s.curso_estudiante
    i.rep_full_name = s.representante_estudiante.mb_chars.titleize
    i.institute = convert_edunit(s.ueducativa_estudiante.mb_chars.titleize)
    i.event = get_event(s.area_formacion.mb_chars.titleize)
    i.observations = s.observaciones.mb_chars.titleize
    i.status = 1
    # s.estado_estudiante
    i.created_at = convert_date s.fi_estudiante

    # Representante 
    r = LegacyRepresentant.find_by_apnom_representante(s.representante_estudiante)
    if r 
      i.rep_document_id = r.id_representante
      i.rep_full_name = r.apnom_representante.mb_chars.titleize
      i.rep_sex = convert_sex r.sexo_representante
      i.rep_title = r.titulo_representante.mb_chars.titleize
      i.rep_phone_home = r.telefonod_representante
      i.rep_phone_celular = r.telefonoc_representante
      i.rep_provincia = r.provincia_representante.mb_chars.titleize
      i.rep_canton = r.canton_representante.mb_chars.titleize
      i.rep_parroquia = r.parroquia_representante.mb_chars.titleize
      i.rep_address = r.direccion_representante.mb_chars.titleize
      i.rep_work_name = r.empresa_representante.mb_chars.titleize
      i.rep_work_address = r.diremp_representante.mb_chars.titleize
      i.rep_work_phone = r.telemp_representante
    end 
    i.save
  end

  LegacyInstructor.all.each do |l|
    i = Instructor.new
    i.document_id = l.id_instructor.mb_chars.titleize
    i.full_name = l.nombresc_instructor.mb_chars.titleize
    i.born_at = convert_date l.fnacimiento_instructor
    i.sex = convert_sex l.sexo_instructor
    i.event = get_event(l.area_instructor.mb_chars.titleize)
    i.title = l.titulo_instructor.mb_chars.titleize
    i.phone = l.telefono_instructor
    i.address = l.direccion_instructor.mb_chars.titleize
    i.phone_home = l.teldir_instructor
    i.save
  end

end

def init_all
  Slot.delete_all 
  Plant.delete_all 
  Inscription.delete_all
  Instructor.delete_all
  Institute.delete_all
  Email.delete_all
  Event.delete_all
  process_all
end
