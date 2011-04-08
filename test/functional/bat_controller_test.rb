require File.dirname(__FILE__) + '/../test_helper'
require 'bat_controller'

# Re-raise errors caught by the controller.
class BatController; def rescue_action(e) raise e end; end

class BatControllerTest < Test::Unit::TestCase
  def setup
    @controller = BatController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
