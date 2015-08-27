require "test_helper"

class PageControllerTest < ActionController::TestCase

  def test_juventud
    get :juventud
    assert_response :success
  end

  def test_audiencia
    get :audiencia
    assert_response :success
  end

  def test_medio_ambiente
    get :medio_ambiente
    assert_response :success
  end

end
