namespace :carchi do 
  namespace :google_calendar do
    desc "[carchi] Cachea los slots diarios conectandose a Google Calendar."
    task cache_slots: :environment do 
      Rails.cache.clear
      Slot.all.each do |slot|
        slot.all_hours_gc(slot.next_day_slot)
        slot.all_hours_gc(slot.nextweek_slot)
      end
    end
  end
end
