require 'test_helper'

class InscriptionsControllerTest < ActionController::TestCase
  setup do
    @inscription = FactoryGirl.build(:inscription)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create inscription" do
    assert_difference('Inscription.count') do
      email = FactoryGirl.create(:email, :pending, category: @inscription.event.category)
      post :create, inscription: { email: @inscription.email, event_id: @inscription.event_id, first_name: @inscription.first_name, last_name: @inscription.last_name, phone: @inscription.phone }
    end

    assert_redirected_to root_path
  end

end
