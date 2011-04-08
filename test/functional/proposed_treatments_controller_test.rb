require File.dirname(__FILE__) + '/../test_helper'
require 'proposed_treatments_controller'

# Re-raise errors caught by the controller.
class ProposedTreatmentsController; def rescue_action(e) raise e end; end

class ProposedTreatmentsControllerTest < Test::Unit::TestCase
  fixtures :proposed_treatments

  def setup
    @controller = ProposedTreatmentsController.new
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

    assert_not_nil assigns(:proposed_treatments)
  end

  def test_show
    get :show, :id => 1

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:proposed_treatment)
    assert assigns(:proposed_treatment).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:proposed_treatment)
  end

  def test_create
    num_proposed_treatments = ProposedTreatment.count

    post :create, :proposed_treatment => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_proposed_treatments + 1, ProposedTreatment.count
  end

  def test_edit
    get :edit, :id => 1

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:proposed_treatment)
    assert assigns(:proposed_treatment).valid?
  end

  def test_update
    post :update, :id => 1
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => 1
  end

  def test_destroy
    assert_not_nil ProposedTreatment.find(1)

    post :destroy, :id => 1
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      ProposedTreatment.find(1)
    }
  end
end
