require File.dirname(__FILE__) + '/../test_helper'
require 'protocol_controller'

# Re-raise errors caught by the controller.
class ProtocolController; def rescue_action(e) raise e end; end

class ProtocolControllerTest < Test::Unit::TestCase
  def setup
    @controller = ProtocolController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
