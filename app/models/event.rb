class Event < ActiveRecord::Base

  has_many :inscriptions
  belongs_to :category

  validates :title, :category, :ttype, presence: true

  TYPE = {
    "Certificado" => 0,
    "Actividad" => 1,
    "Audiencia" => 2,
    "Plantas" => 3,
  }

  def ttype_name
    Event::TYPE.invert[self.ttype]
  end

  def ttype_class
    Event::TYPE.invert[self.ttype].downcase
  end

  scope :type_certificates, -> { where(ttype:0) }
  scope :type_activities, -> { where(ttype:1) }
  scope :type_audience, -> { where(ttype:2) }
  scope :type_trees, -> { where(ttype:3) }

end
