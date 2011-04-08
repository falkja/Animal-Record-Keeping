require File.dirname(__FILE__) + '/../test_helper'
require 'protocol_histories_controller'

# Re-raise errors caught by the controller.
class ProtocolHistoriesController; def rescue_action(e) raise e end; end

class ProtocolHistoriesControllerTest < Test::Unit::TestCase
  fixtures :protocol_histories

  def setup
    @controller = ProtocolHistoriesController.new
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

    assert_not_nil assigns(:protocol_histories)
  end

  def test_show
    get :show, :id => 1

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:protocol_history)
    assert assigns(:protocol_history).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:protocol_history)
  end

  def test_create
    num_protocol_histories = ProtocolHistory.count

    post :create, :protocol_history => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_protocol_histories + 1, ProtocolHistory.count
  end

  def test_edit
    get :edit, :id => 1

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:protocol_history)
    assert assigns(:protocol_history).valid?
  end

  def test_update
    post :update, :id => 1
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => 1
  end

  def test_destroy
    assert_not_nil ProtocolHistory.find(1)

    post :destroy, :id => 1
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      ProtocolHistory.find(1)
    }
  end
end
