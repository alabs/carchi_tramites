require 'gcalendarsync'

class Slot < ActiveRecord::Base

  validates :dow, :starts_hour, :ends_hour, :time, presence: true

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
    date = Date.today
    date += 1 + ((self.dow-date.wday) % 7)
  end

  def next_day_slot_name
    self.next_day_slot.strftime("date_%d%m")
  end

  def nextweek_slot
    self.next_day_slot + 7.days
  end

  def nextweek_slot_name
    self.nextweek_slot.strftime("date_%d%m")
  end

  def all_hours day_slot
    # Comprueba en la base de datos local los ciudadanos que hayan pedido cita
    # quita del listado de todas las horas disponibles los que ya estén pedidos.
    hours = []
    starts_sec = self.starts_hour/100.0*60*60
    ends_sec = self.ends_hour/100.0*60*60
    t = day_slot + starts_sec.seconds
    dates = Inscription.where("DATE(appointed_at) = ?", day_slot).pluck(:appointed_at)
    while t < day_slot + ends_sec.seconds
      hours << [ t.strftime("%H:%M"), t ] unless dates.include? t
      t += self.time.minutes
    end
    hours
  end

  def all_hours_gc day_slot
    # response should be an array of available dates
    # [["08:00", Tue, 23 Feb 2016 08:00:00 PET -05:00], ["08:30", Tue, 23 Feb 2016 08:30:00 PET -05:00], ["09:00", Tue, 23 Feb 2016 09:00:00 PET -05:00], ["09:30", Tue, 23 Feb 2016 09:30:00 PET -05:00], ["10:00", Tue, 23 Feb 2016 10:00:00 PET -05:00], ["10:30", Tue, 23 Feb 2016 10:30:00 PET -05:00], ["11:00", Tue, 23 Feb 2016 11:00:00 PET -05:00], ["11:30", Tue, 23 Feb 2016 11:30:00 PET -05:00], ["12:00", Tue, 23 Feb 2016 12:00:00 PET -05:00], ["12:30", Tue, 23 Feb 2016 12:30:00 PET -05:00], ["13:00", Tue, 23 Feb 2016 13:00:00 PET -05:00], ["13:30", Tue, 23 Feb 2016 13:30:00 PET -05:00], ["14:00", Tue, 23 Feb 2016 14:00:00 PET -05:00], ["14:30", Tue, 23 Feb 2016 14:30:00 PET -05:00], ["15:00", Tue, 23 Feb 2016 15:00:00 PET -05:00], ["15:30", Tue, 23 Feb 2016 15:30:00 PET -05:00]]
    gc = GCalendarSync.new
    hours = gc.cached_call(self, day_slot)
  end

end
