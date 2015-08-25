class EventsMailer < ApplicationMailer

  def limit_reached event_id
    @event = Event.find event_id
    mail to: @event.category.admin_email.to_a, subject: "[carchi] Limite de inscritos en curso #{@event.title}"
  end

end
