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
  end

  describe "new" do

  end

  describe "create" do
    #the work we created is valid # positive test
    it "does something when the work data is valid" do
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
    it "does something when the work data is invalid" do
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

  end

  describe "update" do

  end

  describe "destroy" do

  end
end
