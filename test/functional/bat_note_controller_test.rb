require File.dirname(__FILE__) + '/../test_helper'
require 'bat_note_controller'

# Re-raise errors caught by the controller.
class BatNoteController; def rescue_action(e) raise e end; end

class BatNoteControllerTest < Test::Unit::TestCase
  def setup
    @controller = BatNoteController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
