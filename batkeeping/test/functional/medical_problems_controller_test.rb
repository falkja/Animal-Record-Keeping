require File.dirname(__FILE__) + '/../test_helper'
require 'medical_problems_controller'

# Re-raise errors caught by the controller.
class MedicalProblemsController; def rescue_action(e) raise e end; end

class MedicalProblemsControllerTest < Test::Unit::TestCase
  fixtures :medical_problems

  def setup
    @controller = MedicalProblemsController.new
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

    assert_not_nil assigns(:medical_problems)
  end

  def test_show
    get :show, :id => 1

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:medical_problem)
    assert assigns(:medical_problem).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:medical_problem)
  end

  def test_create
    num_medical_problems = MedicalProblem.count

    post :create, :medical_problem => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_medical_problems + 1, MedicalProblem.count
  end

  def test_edit
    get :edit, :id => 1

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:medical_problem)
    assert assigns(:medical_problem).valid?
  end

  def test_update
    post :update, :id => 1
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => 1
  end

  def test_destroy
    assert_not_nil MedicalProblem.find(1)

    post :destroy, :id => 1
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      MedicalProblem.find(1)
    }
  end
end
