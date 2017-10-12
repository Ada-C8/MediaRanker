require "test_helper"

describe WorksController do
  describe "index " do
    it "returns a success status for all works" do
      get works_path
      must_respond_with :success
    end

    it "returns a success status when there are no books" do
      Work.destroy_all
      get works_path
      must_respond_with :success
    end
  end

  describe "new" do
     
  end
end
