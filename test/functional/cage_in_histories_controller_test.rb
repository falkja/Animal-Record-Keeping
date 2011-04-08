require File.dirname(__FILE__) + '/../test_helper'
require 'cage_in_histories_controller'

# Re-raise errors caught by the controller.
class CageInHistoriesController; def rescue_action(e) raise e end; end

class CageInHistoriesControllerTest < Test::Unit::TestCase
  fixtures :cage_in_histories

  def setup
    @controller = CageInHistoriesController.new
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

    assert_not_nil assigns(:cage_in_histories)
  end

  def test_show
    get :show, :id => 1

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:cage_in_history)
    assert assigns(:cage_in_history).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:cage_in_history)
  end

  def test_create
    num_cage_in_histories = CageInHistory.count

    post :create, :cage_in_history => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_cage_in_histories + 1, CageInHistory.count
  end

  def test_edit
    get :edit, :id => 1

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:cage_in_history)
    assert assigns(:cage_in_history).valid?
  end

  def test_update
    post :update, :id => 1
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => 1
  end

  def test_destroy
    assert_not_nil CageInHistory.find(1)

    post :destroy, :id => 1
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      CageInHistory.find(1)
    }
  end
end
