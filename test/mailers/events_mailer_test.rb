require "test_helper"

class EventsMailerTest < ActionMailer::TestCase

  def setup
    @event = FactoryGirl.create(:event)
  end

  def test_limit_reached
    mail = EventsMailer.limit_reached @event.id
    subject = "[carchi] Limite de inscritos en curso Miércoles: 17:00 a 19:00 - Informática Básica a la Ciudadanía"
    assert_equal subject, mail.subject
    assert_equal ["admin@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
  end

end
