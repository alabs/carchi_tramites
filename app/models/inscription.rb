class Inscription < ActiveRecord::Base

  belongs_to :event
  has_many :inscriptions_plants
  accepts_nested_attributes_for :inscriptions_plants

  #validates_id :document_id, allow_blank: false, only: [:cedula]
  validates :document_id, :sex, :born_at, :address, :parroquia, :canton, :provincia, :first_name, :last_name, :phone, :email, :event, presence: true

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
  }

  STATUS = {
    "Pendiente" => 0,
    "Aprobado"  => 1,
    "Rechazado" => 2
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

  def status_name
    Inscription::STATUS.invert[self.status]
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
    update_attribute(:status, 1)
  end

  def deny!
    update_attribute(:status, 2)
  end

  def full_name
    "#{first_name} #{last_name}"
  end

end
