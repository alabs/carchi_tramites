require 'test_helper'

def test_mail_from_db(action)
  email = FactoryGirl.create(:email, action, category: @inscription.event.category)
  mail = InscriptionMailer.send(action, @inscription.id)
  assert_equal(email.subject, mail.subject)
  assert_equal([@inscription.email], mail.to)
  assert_equal(["from@example.com"], mail.from)
  assert_match(email.body_text, mail.body.encoded)
  assert_match(email.body_html, mail.body.encoded)
end

class InscriptionMailerTest < ActionMailer::TestCase

  setup do
    @inscription = FactoryGirl.create(:inscription)
  end

  test "pending" do
    test_mail_from_db(:pending)
  end

  test "approved" do
    test_mail_from_db(:approved)
  end

  test "denied" do
    test_mail_from_db(:denied)
  end

end
