require File.dirname(__FILE__) + '/../test_helper'
require 'cage_in_history_controller'

# Re-raise errors caught by the controller.
class CageInHistoryController; def rescue_action(e) raise e end; end

class CageInHistoryControllerTest < Test::Unit::TestCase
  def setup
    @controller = CageInHistoryController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
