require "test_helper"

#arrange
#Act
#assert

describe WorksController do

  describe "index" do
    it "returns a success status" do
      gets works_path
      must_respond_with :success
    end
  end

  describe "new" do
    it "" do
    end

    it "" do
    end 

  end

  describe "create" do
    #have two cases - where the creation is valid and where it is not
    it "does something when work data is valid" do
      #arrange
      work_data = {
        work: {
          category: "album",
          title: "Yellow Submarine",
          creator: "The Beatles",
          publication_year: "1965",
        }
      }
      #Test data should result in a valid work, otherwise the test is broken

      Work.new(work_data[:work]).must_be :valid?

      start_work_count = Work.count

      #act
      post works_path, params: work_data

      #assert
      must_respond_with :redirect
      must_redirect_to works_path

      Work.count.must_equal start_work_count + 1
    end

    it "sends bad_request when work data is bogus" do
      #the does something should be that it renders a new form
      #actually we changed it to just sends bad_request
      #arrange
      invalid_work_data = {
        work: {
          #no title
          description: "It is a work!"
        }
      }
      #double check the data is truly invalid
      Work.new(invalid_work_data[:work]).wont_be :valid?

      start_work_count = Work.count

      #act
      post works_path, params: invalid_work_data

      #assert
      must_respond_with :bad_request
      # assert_template :new
      #it may veryify that it rendered the new template; vanilla rails does not provide a way to do this
      Work.count.must_equal start_work_count

      #testing the html rendered is important but a pain and outside the scope
      # will not be checking to see if render

    end
  end

  describe "show" do
    it "returns success when given a valid work id" do
      #arrange
      work_id = Work.first.id
      #act
      get work_path(work_id)
      #assert
      must_respond_with :success

    end

    it "returns not_found when given an invalid work id" do
      #arrange
      invalid_work_id = Work.first.id + 1
      #act
      get work_path(invalid_work_id)
      #assert
      must_respond_with :not_found
    end

  end

  describe "edit" do ## can likely copy from show ### will want to use the same controller logic for show as for edit
    it "returns success when given a valid book id" do
    end

    it "returns not_found when given an invalid book id" do
    end

  end

  describe "update" do #incorporating some from show and some from edit -- need to test those elements
    it "returns success when the work ID is valid and the change is valid" do
    end

    it "returns not_found if the work ID is invalid" do
    end

    it "returns bad_request if the change is invalid" do
    end

  end

  describe "destroy" do
    it "returns success when the book is destroyed" do
    end

    it "returns not_found? or bad_request? "

  end

end
