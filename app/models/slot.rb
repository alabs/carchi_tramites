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

  def format_time time 
    ("%04d" % time).insert(2, ':') 
  end

  def format_starts_hour
    format_time self.starts_hour
  end

  def format_ends_hour
    format_time self.ends_hour
  end

  def dow_name
    Slot::DOW.invert[self.dow]
  end

  def next_day_slot
    date = Date.today+2.days
    date += 1 + ((self.dow-date.wday+2.days) % 7)
  end

  def next_day_slot_name
    self.next_day_slot.strftime("date_%d%m_%H%M")
  end

  def nextweek_slot
    self.next_day_slot + 7.days
  end

  def nextweek_slot_name
    self.nextweek_slot.strftime("date_%d%m_%H%M")
  end

  def all_hours day_slot
    hours = []
    starts_sec = self.starts_hour/100.0*60*60
    ends_sec = self.ends_hour/100.0*60*60
    t = day_slot + starts_sec.seconds
    while t < day_slot + ends_sec.seconds
      hours << [ t.strftime("%H:%M"), t ] 
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
