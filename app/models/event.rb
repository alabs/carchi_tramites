class Event < ActiveRecord::Base

  has_many :inscriptions
  belongs_to :category

  validates :title, :description, :category, :ttype, presence: true

  scope :type_activities, -> { where(ttype:1) }
  scope :type_audience, -> { where(ttype:2) }
  scope :type_trees, -> { where(ttype:3) }

  TYPE = {
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

  def description_html
    self.description? ? self.description.html_safe : nil
  end

end
