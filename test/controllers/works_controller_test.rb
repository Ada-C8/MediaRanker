require "test_helper"

describe "WorksController" do
  it "should go to the index page" do
    get works_path
    must_respond_with :success
  end

  it "should go the the show page of a work" do
    get work_path
  end
end
