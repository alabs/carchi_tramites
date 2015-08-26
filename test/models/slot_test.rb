require "test_helper"

class SlotTest < ActiveSupport::TestCase
  def slot
    @slot ||= Slot.new
  end

  def test_valid
    assert slot.valid?
  end
end
