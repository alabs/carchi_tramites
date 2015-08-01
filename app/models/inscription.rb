class Inscription < ActiveRecord::Base

  belongs_to :event

  validates :first_name, :last_name, :phone, :email, :event, presence: true

  scope :pending, -> { where(status:1) }
  scope :approved, -> { where(status:2) }
  scope :denied, -> { where(status:3) }

  STATUS = {
    "Pendiente" => 1,
    "Aprobado" => 2,
    "Rechazado" => 3
  }

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
    status == 1
  end

  def approve!
    update_attribute(:status, 2)
  end

  def deny!
    update_attribute(:status, 3)
  end

  def full_name
    "#{first_name} #{last_name}"
  end

end
