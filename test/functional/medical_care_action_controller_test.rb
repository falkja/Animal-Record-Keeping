require File.dirname(__FILE__) + '/../test_helper'
require 'medical_care_action_controller'

# Re-raise errors caught by the controller.
class MedicalCareActionController; def rescue_action(e) raise e end; end

class MedicalCareActionControllerTest < Test::Unit::TestCase
  def setup
    @controller = MedicalCareActionController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
