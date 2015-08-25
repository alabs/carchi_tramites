require "test_helper"

class EventsMailerTest < ActionMailer::TestCase
  def test_limit_reached
    mail = EventsMailer.limit_reached
    assert_equal "Limit reached", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
