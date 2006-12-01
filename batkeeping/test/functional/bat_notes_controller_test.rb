require File.dirname(__FILE__) + '/../test_helper'
require 'bat_notes_controller'

# Re-raise errors caught by the controller.
class BatNotesController; def rescue_action(e) raise e end; end

class BatNotesControllerTest < Test::Unit::TestCase
  fixtures :bat_notes

  def setup
    @controller = BatNotesController.new
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

    assert_not_nil assigns(:bat_notes)
  end

  def test_show
    get :show, :id => 1

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:bat_note)
    assert assigns(:bat_note).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:bat_note)
  end

  def test_create
    num_bat_notes = BatNote.count

    post :create, :bat_note => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_bat_notes + 1, BatNote.count
  end

  def test_edit
    get :edit, :id => 1

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:bat_note)
    assert assigns(:bat_note).valid?
  end

  def test_update
    post :update, :id => 1
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => 1
  end

  def test_destroy
    assert_not_nil BatNote.find(1)

    post :destroy, :id => 1
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      BatNote.find(1)
    }
  end
end
