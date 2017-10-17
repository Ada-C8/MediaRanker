require "test_helper"

describe MainController do
  describe "#index" do
    it "return success with accessing the root_path" do
      get root_path

      must_respond_with :success
    end
  end
end
