
class GCalendarSync

  def cached_call slot_obj, day_slot
    Rails.cache.fetch "slot-#{slot_obj.id}_#{day_slot}" do
      call slot_obj, day_slot
    end
  end

  def call slot_obj, day_slot
    # Comprueba conectandose a Google Calendar que fechas encuentra disponible. 
    # quita del listado de todas las horas disponibles los que ya estén pedidos.
    cal = gc_login 
    hours = slot_obj.all_hours day_slot
    time_slot = get_start_minmax slot_obj, hours, day_slot
    events = cal.find_events_in_range(time_slot[:min], time_slot[:max])
    dates = events.collect { |e| DateTime.parse(e.start_time)..DateTime.parse(e.end_time) }
    # FIXME: no deberíamos tener que revisarlo varias veces para que borre, pero sino solo borra algunos
    hours = parse_hours dates, hours
    hours
  end
  
  private

  def gc_login
    cal = Google::Calendar.new(
      :client_id     => Rails.application.secrets.google_calendar["client_id"],
      :client_secret => Rails.application.secrets.google_calendar["secret_key"],
      :calendar      => Rails.application.secrets.google_calendar["calendar_id"],
      :redirect_url  => "urn:ietf:wg:oauth:2.0:oob"
    )
    cal.login_with_refresh_token(Rails.application.secrets.google_calendar["refresh_token"])
    cal
  end

  def get_start_minmax slot_obj, hours, day_slot
    start_min = DateTime.parse hours.first.second.to_s
    start_max = DateTime.parse hours.last.second.to_s
    { min: start_min, max: start_max }
  end

  def parse_hours dates, hours
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
