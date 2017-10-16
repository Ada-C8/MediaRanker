require "test_helper"

describe WorksController do

  let(:invalid_work_id) { Work.last.id + 1 }
  let(:first_work) { Work.first }
  let(:before_work_count) { Work.count}

  before do # Need to log in before any functionality happens
    user_name = User.first.name
    user_data = {
      name: user_name
    }

    post login_path, params: user_data

    # Premade work data
    @work_data = {
      work: {
        category: "book",
        title: "Harry Potter",
        creator: "J.K. Rowling",
        publication_year: 2001,
        description: "A boy to has a scar",
      }
    }
  end

  describe "#index" do
    it "returns success if all Works are valid" do
      before_work_count
      
      get works_path

      must_respond_with :success
      Work.count.must_equal before_work_count
    end

    it "returns a success status when there are no works" do
      Work.destroy_all

      get works_path

      must_respond_with :success
      Work.count.must_equal 0
    end
  end # Describe

  describe "#show" do
    # The ID corresponds to a model in the DB
    # The ID is not found in the DB
    it "returns success when the work_id exists" do
      first_work.must_be :valid?

      get work_path(first_work.id)

      must_respond_with :success
    end

    it "returns not found when the work_id does not exist" do
      invalid_work_id

      get work_path(invalid_work_id)

      must_respond_with :not_found
    end
  end # Des

  describe "#new" do
    # The data was valid
    # The data was bad and validations failed
    it "returns success when accessing the new Work form" do
      get new_work_path

      must_respond_with :success
    end
  end

  describe "#create" do

    it "returns success when all parameters are created and data is valid" do
      # Arrange
                # Variable[:hash]
      Work.new(@work_data[:work]).must_be :valid?
      start_work_count = Work.count

      # Act
      post works_path, params: @work_data

      # Assert
      must_respond_with :redirect
      must_redirect_to works_path
      Work.count.must_equal start_work_count + 1
    end

    it "returns a bad_request if one parameter is invalid" do
      # Arrange - Make the title invalid
      @work_data[:work][:title] = ""

      Work.new(@work_data[:work]).wont_be :valid?
      start_work_count = Work.count

      post works_path, params: @work_data

      # Assert
      must_respond_with :bad_request
      Work.count.must_equal start_work_count
    end

    it "renders a new page when the use if logged out and cannot create a new work" do
      get logout_path

      before_work_count

      post works_path, params: @work_data

      Work.count.must_equal before_work_count
    end
  end # Des

  describe "#edit" do
    it "returns success if the work_id exists" do
      first_work.must_be :valid?

      get work_path(first_work.id)

      must_respond_with :success
    end

    it "returns not_found if the work_id does not exists" do
      invalid_work_id

      get work_path(invalid_work_id)

      must_respond_with :not_found
    end
  end

  describe "#update" do

    before do
      def reload_and_check
        first_work.reload
        first_work.title.wont_equal @work_data[:work][:title]
      end
    end

    it "returns not found when the Work does not exist" do
      invalid_work_id

      patch work_path(invalid_work_id)

      must_respond_with :not_found
    end

    it "returns success if the change is valid" do
      before_work_count

      @work_data[:work][:title] = "I AM CHANGING THE TITLE OF THE THIS BOOK"
      first_work.must_be :valid?
      patch work_path(first_work.id), params: @work_data

      must_respond_with :redirect
      must_redirect_to work_path(first_work.id)

      first_work.reload
      first_work.title.must_equal @work_data[:work][:title]
      Work.count.must_equal before_work_count
    end

    it "returns bad_request if the change is invalid" do
      before_work_count
      first_work.must_be :valid?
      @work_data[:work][:title] = ""

      patch work_path(first_work.id), params: @work_data

      must_respond_with :bad_request

      # Check if change went through
      reload_and_check
      Work.count.must_equal before_work_count
    end

    it "cannot be saved if the user is not logged in" do
      get logout_path

      before_work_count
      first_work.must_be :valid?
      @work_data[:work][:title] = "I AM CHANGING THE TITLE OF THE THIS BOOK"

      patch work_path(first_work.id), params: @work_data

      reload_and_check
      Work.count.must_equal before_work_count
    end
  end # Des

  describe "#destroy" do
    it "returns success when given a valid work ID" do
      before_work_count
      work_id = first_work.id

      delete work_path(work_id)

      must_respond_with :redirect
      must_redirect_to works_path
      Work.find_by(id: work_id).must_equal nil
      Work.count.must_equal before_work_count - 1
    end

    it "returns not found when a given work ID does not exist" do
      invalid_work_id

      delete work_path(invalid_work_id)

      must_respond_with :not_found
    end

    it "cannot be destroyed if the user is not logged in" do
      get logout_path

      before_work_count
      first_work.must_be :valid?

      delete work_path(first_work.id)

      must_respond_with :redirect
      must_redirect_to work_path(first_work.id)
      Work.count.must_equal before_work_count
    end
  end # Des

end # Des
