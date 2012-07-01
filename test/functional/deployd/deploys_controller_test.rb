require 'test_helper'

module Deployd
  class DeploysControllerTest < ActionController::TestCase
    test "should get index" do
      get :index
      assert_response :success
    end
  
  end
end
