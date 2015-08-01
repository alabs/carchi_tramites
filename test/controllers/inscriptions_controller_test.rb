require 'test_helper'

class InscriptionsControllerTest < ActionController::TestCase
  setup do
    @inscription = inscriptions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:inscriptions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create inscription" do
    assert_difference('Inscription.count') do
      post :create, inscription: { email: @inscription.email, event_id: @inscription.event_id, first_name: @inscription.first_name, last_name: @inscription.last_name, phone: @inscription.phone }
    end

    assert_redirected_to inscription_path(assigns(:inscription))
  end

  test "should show inscription" do
    get :show, id: @inscription
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @inscription
    assert_response :success
  end

  test "should update inscription" do
    patch :update, id: @inscription, inscription: { email: @inscription.email, event_id: @inscription.event_id, first_name: @inscription.first_name, last_name: @inscription.last_name, phone: @inscription.phone }
    assert_redirected_to inscription_path(assigns(:inscription))
  end

  test "should destroy inscription" do
    assert_difference('Inscription.count', -1) do
      delete :destroy, id: @inscription
    end

    assert_redirected_to inscriptions_path
  end
end
