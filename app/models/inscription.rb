class Inscription < ActiveRecord::Base

  attr_accessor :office_show, :save_data

  belongs_to :event
  belongs_to :institute
  has_many :inscriptions_plants
  accepts_nested_attributes_for :inscriptions_plants

  #validates_id :document_id, allow_blank: false, only: [:cedula]
  validates :document_id, :sex, :born_at, :address, :parroquia, :canton, :provincia, :first_name, :last_name, :phone, :event, presence: true

  #validates :email, presence: true, unless: self.event.plantas?

  scope :pending,  -> { where(status: 0) }
  scope :approved, -> { where(status: 1) }
  scope :denied,   -> { where(status: 2) }
  scope :female,   -> { where(sex: 0) }
  scope :male, -> { where(sex: 1) }
  scope :last_week,  -> { where("inscriptions.created_at >= ?", 7.days) }
  scope :last_month, -> { where("inscriptions.created_at >= ?", 30.days) }

  before_save :default_values

  SEX = {
    "Mujer" => 0,
    "Hombre" => 1,
    "Otro" => 2,
  }

  STATUS = {
    "Pendiente" => 0,
    "Aprobado"  => 1,
    "Rechazado" => 2
  }

  ED_LEVEL = {
    "1°" => 1,
    "2°" => 2,
    "3°" => 3,
    "4°" => 4,
    "5°" => 5,
    "6°" => 6,
    "7°" => 7,
    "8°" => 8,
    "9°" => 9,
    "10°" => 10,
    "11°" => 11,
    "12°" => 12,
    "13°" => 13,
    "14°" => 14,
    "15°" => 15,
  }

  ED_TITLE = {
    "EDUCACION SECUNDARIA" => 0,
    "EDUCACION SUPERIOR" => 1, 
    "EDUCACION PRIMARIA" => 2,
    "EDUCACION INICIAL PREKINDER" => 3,
    "OTROS" => 4
  }

  def self.by_event_type type
    joins(:event).where('events.ttype = ?', type)
  end

  def default_values
    self.status ||= '0'
  end

  def sex_name
    Inscription::SEX.invert[self.sex]
  end

  def rep_sex_name
    Inscription::SEX.invert[self.rep_sex]
  end

  def status_name
    Inscription::STATUS.invert[self.status]
  end

  def ed_level_name
    Inscription::ED_LEVEL.invert[self.ed_level.to_i]
  end

  def ed_title_name
    Inscription::ED_TITLE.invert[self.ed_title]
  end

  def status_calendar_class
    case status
      when 0 then "status-pending"
      when 1 then "status-ok"
      when 2 then "status-ko"
      else        "status-pending"
    end
  end

  def status_class
    case status
      when 0 then "alert alert-warning"
      when 1 then "alert alert-success"
      when 2 then "alert alert-danger"
      else        "alert alert-warning"
    end
  end

  def pending?
    status == 0
  end

  def approve!
    self.update_attribute(:status, 1)
    self.google_calendar_create!  if self.event.ttype_class == "audiencia" 
  end

  def deny!
    self.update_attribute(:status, 2)
  end

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def google_calendar_create! 
    require 'google_calendar'
    cal = Google::Calendar.new(
      :client_id     => Rails.application.secrets.google_calendar["client_id"],
      :client_secret => Rails.application.secrets.google_calendar["secret_key"],
      :calendar      => Rails.application.secrets.google_calendar["calendar_id"],
      :redirect_url  => "urn:ietf:wg:oauth:2.0:oob"
    )
    cal.login_with_refresh_token(Rails.application.secrets.google_calendar["refresh_token"])
    event = cal.create_event do |e|
      e.title = "Cita con #{self.full_name}"
      e.start_time = self.appointed_at
      e.end_time = self.appointed_at + (30 * 60) # seconds * min
    end
    self.update_attribute(:google_calendar_id, event.id)
    self.update_attribute(:google_calendar_link, event.html_link)
  end

  def get_provincia_name field
    # c_provincia_4
    if field.starts_with? "c_"
      provincia_id = field.split('_')[2]
      type = :provincias
      result = File.open("db/geo/ecuador_#{type}.csv").read().split(/\n/)
      result = result.grep(/^#{provincia_id}\,/).first.split(',')[1]
      result
    else
      field
    end
  end

  def get_canton_name field
    # c_canton_4_3
    if field.starts_with? "c_"
      obj = field.split('_')
      provincia_id = obj[2]
      canton_id = obj[3]
      type = :cantones
      result = File.open("db/geo/ecuador_#{type}.csv").read().split(/\n/)
      result = result.grep(/^#{provincia_id}\,#{canton_id}\,/).first.split(',')[2]
      result
    else
      field
    end
  end

  def get_parroquia_name field
    # c_parroquia_4_1_50
    if field.starts_with? "c_"
      obj = self.parroquia.split('_')
      provincia_id = obj[2]
      canton_id = obj[3]
      parroquia_id = obj[4]
      type = :parroquias
      result = File.open("db/geo/ecuador_#{type}.csv").read().split(/\n/)
      result = result.grep(/^#{provincia_id}\,#{canton_id}\,#{parroquia_id}\,/).first.split(',')[3]
      result
    else
      field
    end
  end

  def provincia_name
    get_provincia_name self.provincia
  end

  def rep_provincia_name
    get_provincia_name self.rep_provincia
  end

  def canton_name 
    get_canton_name self.canton
  end

  def rep_canton_name 
    get_canton_name self.rep_canton
  end

  def parroquia_name
    get_parroquia_name self.parroquia
  end

  def rep_parroquia_name
    get_parroquia_name self.rep_parroquia
  end

end
