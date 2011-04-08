require File.dirname(__FILE__) + '/../test_helper'

class TrainingsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:trainings)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_training
    assert_difference('Training.count') do
      post :create, :training => { }
    end

    assert_redirected_to training_path(assigns(:training))
  end

  def test_should_show_training
    get :show, :id => trainings(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => trainings(:one).id
    assert_response :success
  end

  def test_should_update_training
    put :update, :id => trainings(:one).id, :training => { }
    assert_redirected_to training_path(assigns(:training))
  end

  def test_should_destroy_training
    assert_difference('Training.count', -1) do
      delete :destroy, :id => trainings(:one).id
    end

    assert_redirected_to trainings_path
  end
end
