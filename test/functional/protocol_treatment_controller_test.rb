require File.dirname(__FILE__) + '/../test_helper'
require 'protocol_treatment_controller'

# Re-raise errors caught by the controller.
class ProtocolTreatmentController; def rescue_action(e) raise e end; end

class ProtocolTreatmentControllerTest < Test::Unit::TestCase
  def setup
    @controller = ProtocolTreatmentController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
