require "test_helper"

describe WorksController do

  describe "login" do
    test "should get new" do
      get login_path
      must_respond_with :success
    end
  end

end
