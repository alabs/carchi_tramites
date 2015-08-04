require "test_helper"

class EmailTest < ActiveSupport::TestCase
  def email
    @email ||= Email.new
  end

  def test_valid
    assert email.valid?
  end
end
