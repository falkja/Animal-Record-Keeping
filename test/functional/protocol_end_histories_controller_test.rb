require File.dirname(__FILE__) + '/../test_helper'
require 'protocol_end_histories_controller'

# Re-raise errors caught by the controller.
class ProtocolEndHistoriesController; def rescue_action(e) raise e end; end

class ProtocolEndHistoriesControllerTest < Test::Unit::TestCase
  fixtures :protocol_end_histories

  def setup
    @controller = ProtocolEndHistoriesController.new
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

    assert_not_nil assigns(:protocol_end_histories)
  end

  def test_show
    get :show, :id => 1

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:protocol_end_history)
    assert assigns(:protocol_end_history).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:protocol_end_history)
  end

  def test_create
    num_protocol_end_histories = ProtocolEndHistory.count

    post :create, :protocol_end_history => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_protocol_end_histories + 1, ProtocolEndHistory.count
  end

  def test_edit
    get :edit, :id => 1

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:protocol_end_history)
    assert assigns(:protocol_end_history).valid?
  end

  def test_update
    post :update, :id => 1
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => 1
  end

  def test_destroy
    assert_not_nil ProtocolEndHistory.find(1)

    post :destroy, :id => 1
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      ProtocolEndHistory.find(1)
    }
  end
end
