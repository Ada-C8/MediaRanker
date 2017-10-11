require "test_helper"

describe WorksController do
  let(:album) { works(:album) }

  it "should get index" do
    get works_path
    must_respond_with :success
  end

  it "should get show path with a valid work id" do
    # successful with valid id
    get work_path(album.id)
    must_respond_with :success, "Did not get the show page for a valid id"
    # redirects with invalid id
    get work_path(-1)
    must_respond_with :not_found
  end
end
