# Preview all emails at http://localhost:3000/rails/mailers/events_mailer
class EventsMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/events_mailer/limit_reached
  def limit_reached
    EventsMailer.limit_reached
  end

end
