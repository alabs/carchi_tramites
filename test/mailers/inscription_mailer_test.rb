require 'test_helper'

class InscriptionMailerTest < ActionMailer::TestCase
  test "new" do
    inscription = FactoryGirl.create :inscription
    mail = InscriptionMailer.new inscription.id
    assert_equal "[carchi-juventud] Has sido inscrito a la actividad", mail.subject
    assert_equal [inscription.email], mail.to
    assert_equal ["from@example.com"], mail.from
    #assert_match "Hi", mail.body.encoded
  end

  test "approved" do
    inscription = FactoryGirl.create :inscription
    mail = InscriptionMailer.approved inscription.id
    assert_equal "[carchi-juventud] Has sido aprovado para la actividad", mail.subject
    assert_equal [inscription.email], mail.to
    assert_equal ["from@example.com"], mail.from
    #assert_match "Hi", mail.body.encoded
  end

  test "denied" do
    inscription = FactoryGirl.create :inscription
    mail = InscriptionMailer.denied inscription.id
    assert_equal "[carchi-juventud] No has sido aprovado para la actividad", mail.subject
    assert_equal [inscription.email], mail.to
    assert_equal ["from@example.com"], mail.from
    #assert_match "Hi", mail.body.encoded
  end

end
