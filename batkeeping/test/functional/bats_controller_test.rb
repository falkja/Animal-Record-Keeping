require File.dirname(__FILE__) + '/../test_helper'
require 'bats_controller'

# Re-raise errors caught by the controller.
class BatsController; def rescue_action(e) raise e end; end

class BatsControllerTest < Test::Unit::TestCase
  fixtures :bats

  def setup
    @controller = BatsController.new
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

    assert_not_nil assigns(:bats)
  end

  def test_show
    get :show, :id => 1

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:bat)
    assert assigns(:bat).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:bat)
  end

  def test_create
    num_bats = Bat.count

    post :create, :bat => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_bats + 1, Bat.count
  end

  def test_edit
    get :edit, :id => 1

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:bat)
    assert assigns(:bat).valid?
  end

  def test_update
    post :update, :id => 1
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => 1
  end

  def test_destroy
    assert_not_nil Bat.find(1)

    post :destroy, :id => 1
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      Bat.find(1)
    }
  end
end
