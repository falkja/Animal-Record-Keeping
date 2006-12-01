require File.dirname(__FILE__) + '/../test_helper'
require 'cage_out_history_controller'

# Re-raise errors caught by the controller.
class CageOutHistoryController; def rescue_action(e) raise e end; end

class CageOutHistoryControllerTest < Test::Unit::TestCase
  def setup
    @controller = CageOutHistoryController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
