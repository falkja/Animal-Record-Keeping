require File.dirname(__FILE__) + '/../test_helper'
require 'protocol_start_history_controller'

# Re-raise errors caught by the controller.
class ProtocolStartHistoryController; def rescue_action(e) raise e end; end

class ProtocolStartHistoryControllerTest < Test::Unit::TestCase
  def setup
    @controller = ProtocolStartHistoryController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
