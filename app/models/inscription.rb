class Inscription < ActiveRecord::Base

  belongs_to :event

  validates :first_name, :last_name, :phone, :email, :event, presence: true

  scope :pending, -> { where(status: 0) }
  scope :approved, -> { where(status: 1) }
  scope :denied, -> { where(status: 2) }

  scope :last_week, -> { where("inscriptions.created_at >= ?", 7.days) }
  scope :last_month, -> { where("inscriptions.created_at >= ?", 30.days) }

  before_save :default_values

  STATUS = {
    "Pendiente" => 1,
    "Aprobado" => 2,
    "Rechazado" => 3
  }

  def self.by_event_type type
    joins(:event).where('events.ttype = ?', type)
  end

  def default_values
    self.status ||= '0'
  end

  def status_name
    Inscription::STATUS.invert[self.status]
  end

  def status_class
    case status
      when 1 then "alert alert-warning"
      when 2 then "alert alert-success"
      when 3 then "alert alert-danger"
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
