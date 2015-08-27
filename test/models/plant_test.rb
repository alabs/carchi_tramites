require "test_helper"

class PlantTest < ActiveSupport::TestCase
  def plant
    @plant ||= Plant.new
  end

  def test_valid
    assert_not plant.valid?
    assert plant.errors[:name].include? "no puede estar en blanco"
    plant.name = "Ciprés"
    assert plant.valid?
  end
end
