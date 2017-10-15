require "test_helper"

describe WorksController do
  # it "must be a real test" do
  #   flunk "Need real tests"
  # end

  describe "index" do
    it "returns a success status for all books" do
      get works_path
      must_respond_with :success
    end

    it "returns a sucess status when there are no works" do
      Work.destroy_all
      get works_path
      must_respond_with :success
    end


    # I am unsure if this applies.
    it "returns a success status when given a valid user_id" do
      get work_user_path(User.first)
      must_respond_with :success
    end
  end # end describe

  describe "new" do
    it "works with a valid work id" do
      get
    end
  end

end


















puts
