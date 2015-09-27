class Event < ActiveRecord::Base

  extend FriendlyId
  friendly_id :title, use: :slugged

  has_many :inscriptions
  has_many :emails

  validates :title, :description, :ttype, presence: true

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

  def has_reached_limit?
    self.inscriptions.approved.size >= self.limit if self.limit
  end


end
