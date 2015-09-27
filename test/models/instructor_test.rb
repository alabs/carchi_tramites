require "test_helper"

class InstructorTest < ActiveSupport::TestCase
  def instructor
    @instructor ||= Instructor.new
  end

  def test_valid
    assert instructor.valid?
  end
end
