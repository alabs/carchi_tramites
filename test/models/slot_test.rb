require "test_helper"

class SlotTest < ActiveSupport::TestCase
  def slot
    @slot ||= Slot.new
  end

  def test_valid
    assert_not slot.valid?
    assert slot.errors[:dow].include? "no puede estar en blanco"
    assert slot.errors[:starts_hour].include? "no puede estar en blanco"
    assert slot.errors[:ends_hour].include? "no puede estar en blanco"
    assert slot.errors[:time].include? "no puede estar en blanco"
    slot.dow = 2
    slot.starts_hour = 900
    slot.ends_hour = 1800
    slot.time = 60
    assert slot.valid?
  end

  def test_dow_name
    slot.dow = 2
    assert_equal "Miércoles", slot.dow_name
  end

end
