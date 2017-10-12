require "test_helper"

describe WorksController do
  let :work_data {
    work_data = {
      work: {
      title: "Test Title"
      }
    }
  }
  let :invalid_work_data {
    invalid_work_data = {
      work: {
      title: ""
      }
    }
  }
  let :work_id { Work.last.id }
  let :hp { works(:hp1) }

  describe "index" do
    it "returns a success status for all works" do
      get works_path
      must_respond_with :success
    end

    it "returns a success status for no works" do
      Work.destroy_all
      get works_path
      must_respond_with :success
    end

    #------- test nested routes
    # it "returns a success status when given a valid author id" do
      # get author_books_path(Author.first)
      # must_respond_with :success
    # end

    # opposite:
    # get author_books_path(Author.last.id + 1)
    # must_respond_with :not_found
  end

  describe "new" do
    it "returns a success status for new form" do
      get new_work_path
      must_respond_with :success
    end
  end

  describe "create" do
    it "redirects to all works when the work data is valid" do

      Work.new(work_data[:work]).must_be :valid?
      start_work_count = Work.count
      post works_path, params: work_data
      must_respond_with :redirect
      must_redirect_to works_path

      Work.count.must_equal start_work_count + 1
    end

    it "sends bad_request when the work data is invalid" do

      Work.new(invalid_work_data[:work]).wont_be :valid?
      start_work_count = Work.count
      post works_path, params: invalid_work_data
      must_respond_with :bad_request
      # assert_template :new

      Work.count.must_equal start_work_count

    end
  end

  describe "show" do
    it "returns success when given a vaild id" do
      get work_path(work_id)
      must_respond_with :success
    end
    it "returns not_found when given an invaild id" do
      get work_path(work_id + 1)
      must_respond_with :not_found
    end

  end

  describe "edit" do
    it "returns success when given a vaild id" do
      get edit_work_path(work_id)
      must_respond_with :success
    end
    it "returns not_found when given an invaild id" do
      get edit_work_path(work_id + 1)
      must_respond_with :not_found
    end
  end

  describe "update" do
    it "returns not_found when given an invaild id" do
      put work_path(work_id + 1), params: work_data
      must_respond_with :not_found
    end

    it "returns succes if the work exists and the change is valid" do

      hp.must_be :valid?
      put work_path(hp), params: work_data
      must_respond_with :redirect
      must_redirect_to work_path(hp)
    end


    it "returns bad_request if the change is invalid" do
      #  don't quite know how to check invalidity here....
      put work_path(hp), params: invalid_work_data
      must_respond_with :bad_request
    end
  end

  describe "destroy" do
    it "returns success if the work was destroyed" do
      total = Work.count
      delete work_path(hp)
      must_respond_with :redirect
      must_redirect_to works_path
      total.must_equal Work.count + 1
    end

    it "returns not_found when given an invaild id" do
      put work_path(work_id + 1)
      must_respond_with :not_found
    end

  end
end
