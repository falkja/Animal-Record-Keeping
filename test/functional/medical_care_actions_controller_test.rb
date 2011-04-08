require File.dirname(__FILE__) + '/../test_helper'
require 'medical_care_actions_controller'

# Re-raise errors caught by the controller.
class MedicalCareActionsController; def rescue_action(e) raise e end; end

class MedicalCareActionsControllerTest < Test::Unit::TestCase
  fixtures :medical_care_actions

  def setup
    @controller = MedicalCareActionsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_index
    get :index
    assert_response :success
    assert_template 'list'
  end

  def test_list
    get :list

    assert_response :success
    assert_template 'list'

    assert_not_nil assigns(:medical_care_actions)
  end

  def test_show
    get :show, :id => 1

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:medical_care_action)
    assert assigns(:medical_care_action).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:medical_care_action)
  end

  def test_create
    num_medical_care_actions = MedicalCareAction.count

    post :create, :medical_care_action => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_medical_care_actions + 1, MedicalCareAction.count
  end

  def test_edit
    get :edit, :id => 1

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:medical_care_action)
    assert assigns(:medical_care_action).valid?
  end

  def test_update
    post :update, :id => 1
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => 1
  end

  def test_destroy
    assert_not_nil MedicalCareAction.find(1)

    post :destroy, :id => 1
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      MedicalCareAction.find(1)
    }
  end
end
