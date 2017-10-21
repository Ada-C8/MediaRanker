require "test_helper"

describe WorksController do
  describe "index" do
    it "returns a success status" do
      get works_path
      must_respond_with :success
    end

    # to keep thinking about: #################
    # do we need to test nested routes? We created two tests in the books_controller_test.rb

    it "returns a success status when there are no works" do
      Work.destroy_all
      get works_path
      must_respond_with :success
    end

    it "sorts the categories correctly" do
      # not sure how to test that @movies is only showing the category movie
    end
  end

  describe "show" do
    it "returns success when given a valid work id" do
      work_id = Work.first.id
      # user_id = session[:user_id]
      get work_path(work_id)
      must_respond_with :success
    end

    it "returns not_found when given a bad work id" do
      bad_work_id = Work.last.id + 1
      get work_path(bad_work_id)
      must_respond_with :not_found
    end
  end

  describe "new" do
    it "creates a new work successfully" do
      get new_work_path
      must_respond_with :success
    end
  end

  describe "create" do
    #the work we created is valid # positive test
    it "saves and redirects to works_path when the work data is valid" do
      work_data = {
        work: {
          category: "book",
          title: "test book name",
        }
      }
      Work.new(work_data[:work]).must_be :valid?
      start_work_count = Work.count

      post works_path, params: work_data
      must_respond_with :redirect
      must_redirect_to works_path
      Work.count.must_equal start_work_count + 1
    end

    # negative test
    it "renders a bad_request when the work data is invalid" do
      # arrange
      bad_work = {
        work: {
          category: "book",
          # no title given!!
        }
      }
      Work.new(bad_work[:work]).wont_be :valid?
      start_work_count = Work.count
      # act
      post works_path, params: bad_work
      # assert
      must_respond_with :bad_request
      Work.count.must_equal start_work_count
    end
  end

  describe "edit" do
    it "returns success when given a valid work id" do
      work_id = Work.first.id
      get work_path(work_id)
      must_respond_with :success
    end

    it "returns not_found when given a bad work id" do
      bad_work_id = Work.last.id + 1
      get work_path(bad_work_id)
      must_respond_with :not_found
    end
  end

  describe "update" do
    it "returns success when change is valid" do
      work = Work.first
      work_data = {
        work: {
          category: "book",
          title: "Changed title"
        }
      }
      work.update_attributes(work_data[:work])
      work.must_be :valid?

      patch work_path(work), params: work_data
      must_respond_with :redirect
      must_redirect_to work_path(work)

      work.reload
      work.title.must_equal work_data[:work][:title]
    end

    it "returns not_found if work id is invalid" do
      bad_work_id = Work.last.id + 1
      work_data = {
        work: {
          title: " title"
        }
      }
      patch work_path(bad_work_id), params: work_data
      must_respond_with :not_found
    end

    it "returns bad_request when change is invalid" do
      work = Work.first
      bad_work_data = {
        work: {
          title: ""
        }
      }
      work.update_attributes(bad_work_data[:work])
      work.wont_be :valid?
      start_work_count = Work.count

      patch work_path(work), params: bad_work_data
      must_respond_with :bad_request
      Work.count.must_equal start_work_count
    end

  end

  describe "destroy" do
    it "success when book is deleted" do
      work_count = Work.count
      delete work_path(Work.first)
      must_respond_with :redirect
      must_redirect_to works_path
      work_count.must_equal Work.count + 1
    end

    # no scenario in which a deletion does not happen in this project
    # it "test negative delete" do
    # work_count = Work.count
    # delete work_path(Work.first)
    # must_respond_with :redirect
    # must_redirect_to works_path
    # work_count.must_equal Work.count
    # end

  end
end
