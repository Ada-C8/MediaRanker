require "test_helper"

describe "WorksController" do
  # it "must be a real test" do
  #   flunk "Need real tests"
  # end

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
    it "returns a success status for creating a new work" do
      get new_work_path
      must_respond_with :success
    end
  end

  describe "create" do
    it "adds the work to the database and redirects when the work data is valid" do
      #arrange
      work_data = {
        work: {
          category: "book",
          title: "When Nietzsche Wept",
          creator: "Irvin Yalom",
          publication_year: 1990,
          description: "Read it"
        }
      }

      Work.new(work_data[:work]).must_be :valid?

      start_work_count = Work.count

      #act
      post works_path, params: work_data

      #assert
      must_respond_with :redirect
      must_redirect_to works_path

      Work.count.must_equal start_work_count + 1
    end

    it "sends a bad_request when the work data is invalid" do
      #arrange
      invalid_work_data = {
        work: {
          category: "book",
          title: "Civilizations and its Discontents"
        }
      }

      Work.new(invalid_work_data[:work]).wont_be :valid?

      start_work_count = Work.count

      #act
      post works_path, params: invalid_work_data

      #assert
      must_respond_with :bad_request
      Work.count.must_equal start_work_count
    end
  end

  describe "edit" do
    it "returns a success status when given a valid work ID" do
      work_id = Work.first.id
      get edit_work_path(work_id)
      must_respond_with :success
    end

    it "returns not_found when given an invalid work ID" do
      invalid_work_id = Work.last.id + 1
      get edit_work_path(invalid_work_id)
      must_respond_with :not_found
    end
  end

  describe "update" do
    it "returns a success status if the work ID is valid and the change is valid" do
      work = Work.first
      work_data = {
        work: {
          category: work.category,
          title: work.title,
          creator: work.creator,
          publication_year: work.publication_year,
          description: "change description"
        }
      }

      work.update_attributes(work_data[:work])
      work.must_be :valid?

      patch work_path(work.id), params: work_data
      work.reload

      work.description.must_equal work_data[:work][:description]
    end

    it "returns not_found when given an invalid work ID" do
      invalid_work_id = Work.last.id + 1
      book_data = {
        work: {
          category: Work.first.category,
          title: "different title",
          creator: Work.first.creator
        }
      }

      patch work_path(invalid_work_id), params: book_data
      must_respond_with :not_found
    end

    it "returns bad_request if the change is invalid" do
      work = Work.first
      invalid_work_data = {
        work: {
          category: work.category,
          title: "",
          creator: work.creator
        }
      }

      work.update_attributes(invalid_work_data[:work])
      work.wont_be :valid?

      patch work_path(work.id), params: invalid_work_data

      must_respond_with :bad_request
      work.reload

      work.title.wont_equal invalid_work_data[:work][:title]
    end

  end

  describe "destory" do
    it "returns a success status and destroys the work when given a valid work ID" do
      work_id = Work.first.id

      delete work_path(work_id)

      must_respond_with :redirect
      must_redirect_to works_path
      Work.find_by(id: work_id).must_be_nil
    end

    it "returns not_found when given an invalid work ID" do
      invalid_work_id = Work.first.id + 1

      start_work_count = Work.count

      delete work_path(invalid_work_id)

      must_respond_with :not_found
      Work.count.must_equal start_work_count

    end
  end

end
