class Institute < ActiveRecord::Base
  has_many :inscriptions

  TYPE = {
    "Prekinder" => 0,
    "Kinder" => 1,
    "Primaria" => 2,
    "Secundaria" => 3,
    "Superior" => 4,
    "Otras" => 5,
  }

  def ttype_name
    Institute::TYPE.invert[self.ttype]
  end

end
