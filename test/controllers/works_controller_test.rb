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
    must_respond_with :not_found, "Incorrectly got the show page for invalid id"
  end

  it "should get the new path" do
    get new_work_path
    must_respond_with :success
  end

  describe "creating a new work" do
    it "should add a new work to the db with the create path" do
      work = Work.find_by(title: "A new work")
      work.must_equal nil
      proc {
        post create_work_path, params: {work: {title: "A new work", creator: "A creator"}}
      }.must_change 'Work.count', +1
      must_redirect_to works_path
      work = Work.find_by(title: "A new work")
      work.must_be_instance_of Work
    end

    it "should not create a new work with invalid params" do
      skip
      #i need to modify the controller to raise an error here
      #requires a creator
      post create_work_path, params: {work: {title: "A new work", creator: nil}}

    end

    it "should not create a new work if it is not unique" do
      skip
    end
  end
end
