require File.dirname(__FILE__) + '/../test_helper'
require 'cage_histories_controller'

# Re-raise errors caught by the controller.
class CageHistoriesController; def rescue_action(e) raise e end; end

class CageHistoriesControllerTest < Test::Unit::TestCase
  fixtures :cage_histories

  def setup
    @controller = CageHistoriesController.new
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

    assert_not_nil assigns(:cage_histories)
  end

  def test_show
    get :show, :id => 1

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:cage_history)
    assert assigns(:cage_history).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:cage_history)
  end

  def test_create
    num_cage_histories = CageHistory.count

    post :create, :cage_history => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_cage_histories + 1, CageHistory.count
  end

  def test_edit
    get :edit, :id => 1

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:cage_history)
    assert assigns(:cage_history).valid?
  end

  def test_update
    post :update, :id => 1
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => 1
  end

  def test_destroy
    assert_not_nil CageHistory.find(1)

    post :destroy, :id => 1
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      CageHistory.find(1)
    }
  end
end
