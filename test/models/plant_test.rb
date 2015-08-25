require "test_helper"

class PlantTest < ActiveSupport::TestCase
  def plant
    @plant ||= Plant.new
  end

  def test_valid
    assert plant.valid?
  end
end
