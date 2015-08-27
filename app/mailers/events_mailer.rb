class EventsMailer < ApplicationMailer

  def limit_reached event_id
    @event = Event.find event_id
    if @event.category.admin_email
      mail to: @event.category.admin_email.split(','), subject: "[carchi] Limite de inscritos en curso #{@event.title}"
    end
  end

end
