class Email < ActiveRecord::Base

  belongs_to :event

  TYPE = {
    "Pendiente: al inscribirse un ciudadano" => 0,
    "Aprobado: al ser aprobado por un administrador" => 1,
    "Denegado: al ser rechazado" => 2,
  }

  def ttype_name
    Email::TYPE.invert[self.ttype]
  end

end
