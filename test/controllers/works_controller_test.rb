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
    it "works successfully" do
      get new_work_path
      must_respond_with :success
    end
  end

  describe "create" do
    it "saves new work to DB and redirect_to works_path" do
      work_data = {
        work: {
          category: "movie",
          title: "test movie"
        }
      }

      work = Work.new(work_data[:work]).must_be :valid?

      start_work_count = Work.count

      #act
      post works_path, params: work_data

      #Assert
      must_respond_with :redirect
      must_redirect_to works_path

      Work.count.must_equal start_book_count + 1
    end

    it "renders to new page and responds with bad_request" do
      invalid_work_data = {
        work: {
          #no catergory
          title: "test work"
        }
      }

      #double check the data is invalid

      Book.new(invalid_work_data[:work]).wowont_be :valid?

      start_work_count = Work.count

      post works_path, params: invalid_work_data

      must_respond_with :bad_request

      Work.count.must_equal start_work_count
    end
  end #end create

  describe "show" do
    it "returns success when given a valid work id" do
      work_id = Work.first.id

      get work_path(work_id)

      must_respond_with :success
    end

    it "returns not_found when given an invalid_work_id" do
      invalid_work_id = Work.last.id + 1
      get work_path(invalid_work_id)
      must_respond_with :not_found
    end
  end #end show

  describe "edit" do
    it "returns success when given a valid work id" do
      work_id = Work.first.id

      get work_path(work_id)

      must_respond_with :success
    end

    it "returns not_found when given an invalid_work_id" do
      invalid_work_id = Work.last.id + 1
      get work_path(invalid_work_id)
      must_respond_with :not_found
    end
  end #end edit

  describe "update" do
    it "successfully saves update to database and redirect_to work_path for updated work." do
      work = Work.new(catergory: "album", title: "test")

      patch work_path(work)

      must_respond_with :success
      must_redirect_to work_path()
    end
  end #end update

  describe "destroy" do

  end #end destroy
end


















puts
