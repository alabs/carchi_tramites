require "test_helper"

class PageControllerTest < ActionController::TestCase

  def test_audiencia
    FactoryGirl.create(:event, :audiencia)
    get :audiencia
    assert_response :redirect
  end

  def test_medio_ambiente
    FactoryGirl.create(:event, :plantas)
    get :medio_ambiente
    assert_response :redirect
  end

end
