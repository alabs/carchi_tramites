require "test_helper"

class InstituteTest < ActiveSupport::TestCase
  def institute
    @institute ||= Institute.new
  end

  def test_valid
    assert institute.valid?
  end
end
