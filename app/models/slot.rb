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
      # FIXME: duration from DB
      t += 30.minutes
    end
    hours
  end

  def all_hours_gc day_slot
    # Comprueba conectandose a Google Calendar que fechas encuentra disponible. 
    # quita del listado de todas las horas disponibles los que ya estén pedidos.
    cal = Google::Calendar.new(
      :client_id     => Rails.application.secrets.google_calendar["client_id"],
      :client_secret => Rails.application.secrets.google_calendar["secret_key"],
      :calendar      => Rails.application.secrets.google_calendar["calendar_id"],
      :redirect_url  => "urn:ietf:wg:oauth:2.0:oob"
    )
    cal.login_with_refresh_token(Rails.application.secrets.google_calendar["refresh_token"])
    hours = self.all_hours day_slot
    start_min = DateTime.parse hours.first.second.to_s
    start_max = DateTime.parse hours.last.second.to_s
    events = cal.find_events_in_range(start_min, start_max)
    dates = events.collect { |e| DateTime.parse(e.start_time)..DateTime.parse(e.end_time) }
    # FIXME: no deberíamos tener que revisarlo varias veces para que borre, pero sino solo borra algunos
    hours = process_date dates, hours
    hours = process_date dates, hours
    hours = process_date dates, hours
    hours = process_date dates, hours
    hours = process_date dates, hours
    hours = process_date dates, hours
    hours = process_date dates, hours
    hours
  end

  def process_date dates, hours
    hours.each do |hour|
      dates.each { |date| hours.delete(hour) if date.cover? hour.second }
    end
  end

end
