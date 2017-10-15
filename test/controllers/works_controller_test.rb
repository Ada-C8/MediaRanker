require "test_helper"

describe WorksController do
  describe "index" do
    it "returns a success status for all works" do
      get works_path
      must_respond_with :success
    end

    it "returns a success status when there are no works" do
      Work.destroy_all
      get works_path
      must_respond_with :success
    end
  end

  describe "new" do
    it "returns a success status" do
      get new_work_path
      must_respond_with :success
    end
  end

  describe "create" do
    it "redirects to works_path when the work data is valid and adds a work" do
      work_data = {
        work: {
          title: "test work",
          creator: "test creator",
          pub_year: 2000,
          category: "Book"
        }
      }
      #test data should result in valid work if not it will break
      Work.new(work_data[:work]).must_be :valid?
      work_count = Work.count
      post works_path, params: work_data
      must_respond_with :redirect
      must_redirect_to works_path
      Work.count.must_equal work_count + 1
    end

    it "redirects to works_path when the work data is not valid and doesn't add a work" do
      work_data = {
        work: {
          title: nil,
          creator: nil,
          pub_year: nil,
          category: nil
        }
      }
      #test data should result in valid work if not it will break
      Work.new(work_data[:work]).wont_be :valid?
      work_count = Work.count
      post works_path, params: work_data
      must_respond_with :bad_request
      Work.count.must_equal work_count
    end
  end

  describe "show" do
    it "returns a success status when passed a valid id" do
      work_id = Work.first.id
      get work_path(work_id)
      must_respond_with :success
    end

    it "returns not_found when given a bogus work id" do
      bad_work_id = Work.last.id + 1
      get work_path(bad_work_id)
      must_respond_with :not_found
    end
  end

  describe "edit" do
    it "returns a success status when passed a valid work id" do
      work_id = Work.first.id
      get edit_work_path(work_id)
      must_respond_with :success
    end

    it "returns not found when passed a bogus work id" do
      bad_work_id = Work.last.id + 1
      get work_path(bad_work_id)
      must_respond_with :not_found
    end
  end

#WORK ON THESE UPDATE TESTS!!!
  describe "update" do
    it "returns success if the book exists and the change is valid" do
      work = Work.first


      work_data = {
        work: {
          title: "changed title",
        }
      }
      work.update_attributes(work_data[:work])
      work.must_be :valid?
      patch work_path(work), params: work_data

      must_respond_with :redirect
      must_redirect_to work_path(work.id)
      work.reload
      work.title.must_equal work_data[:work][:title]

    end

    it "returns not_found if the book doesn't exist" do
      invalid_work_id = Work.last.id + 1
      work_data = {
        work: {
          title: "changed title"
        }
      }

      #WHY IS IT TRYING TO FIND WORK BEFORE MUST RESPOND

      patch work_path(invalid_work_id), params: work_data
      must_respond_with :not_found

    end


    it "returns bad_request if the change is invalid" do
      work = Work.first
      work_data = {
        work: {
          title: nil
        }
      }
      work.update_attributes(work_data[:work])
      work.wont_be :valid?
      patch work_path(work.id), params: work_data
      must_respond_with :bad_request

      work.reload
    end

  end

  describe "destroy" do
    #book exists or the book doesn't exist
    it "returns success and destroys the work when given a valid work ID" do
      work_id = Work.first.id
      delete work_path(work_id)
      must_respond_with :redirect
      must_redirect_to works_path
      Work.find_by(id: work_id).must_be_nil
    end

    it "returns not_found when given an invalid work ID" do
      invalid_work_id = Work.last.id + 1
      work_count = Work.count
      delete work_path(invalid_work_id)
      must_respond_with :not_found
      Work.count.must_equal work_count
    end

  end




end
