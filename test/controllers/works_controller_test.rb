require "test_helper"

describe WorksController do
  it "the books index page is successful" do
    get works_path
    must_respond_with :success
  end

  it "successfully loads the new_work form" do
    get new_work_path
    must_respond_with :success
  end

end
