class Slot < ActiveRecord::Base

  validates :dow, presence: true

  DOW = {
    "Lunes" => 0,
    "Martes" => 1,
    "Miércoles" => 2,
    "Jueves" => 3,
    "Viernes" => 4,
    "Sábado" => 5,
    "Domingo" => 6,
  }

  def dow_name
    Slot::DOW.invert[self.dow]
  end

  def next_day_slot
    DateTime.now.next_week.next_day(self.dow)
  end

  def all_hours
    hours = []
    starts_sec = self.starts_hour/100.0*60*60
    ends_sec = self.ends_hour/100.0*60*60
    nds = self.next_day_slot
    t = nds + starts_sec.seconds
    while t < nds + ends_sec.seconds
      hours << [ I18n.l(t, format: :long), t ] 
      t += 30.minutes
    end
    hours
  end

  def self.all_hours
    hours = []
    Slot.all.each do |slot|
      hours += slot.all_hours
    end
    hours
  end

end
