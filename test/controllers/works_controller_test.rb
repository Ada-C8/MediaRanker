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

  end #index tests

  describe "new" do
    it "gets a new form" do
      get new_work_path
      must_respond_with :success
    end
  end #new tests



  describe "create" do
    it "adds the work to the DB and redirects when the work data is valid" do
      # Arrange
      work_data = {
        work: {
          title: "Test work"
        }
      }
      # Test data should result in a valid work, otherwise
      # the test is broken
      Work.new(work_data[:work]).must_be :valid?

      start_work_count = Work.count

      # Act
      post works_path, params: work_data

      # Assert
      must_respond_with :redirect
      must_redirect_to works_path

      Work.count.must_equal start_work_count + 1
    end #adds work test

    it "sends bad_request when the work data is bogus" do
      # Arrange
      invalid_work_data = {
        work: {
          # NO TITLE!!!
          creator: "Fake Creator"
        }
      }
      # Double check the data is truly invalid
      Work.new(invalid_work_data[:work]).wont_be :valid?

      start_work_count = Work.count

      # Act
      post works_path, params: invalid_work_data

      # Assert
      must_respond_with :bad_request
      # Vanilla rails doesn't provide any way to do this
      # assert_template :new
      Work.count.must_equal start_work_count
    end #bad request
  end #create



  describe "show" do
    it "returns success when given a valid work ID" do
      # Arrange
      work_id = Work.first.id

      # Act
      get work_path(work_id)

      # Assert
      must_respond_with :success
    end

    it "returns not_found when given an invalid book ID" do
      invalid_work_id = Work.last.id + 1
      get work_path(invalid_work_id)
      must_respond_with :not_found
    end
  end

  describe "edit" do
    it "returns success when given a valid work ID" do
      # Arrange
      work_id = Work.first.id

      # Act
      get edit_work_path(work_id)

      # Assert
      must_respond_with :success
    end

    it "returns not_found when given an invalid work ID" do
      invalid_work_id = Work.last.id + 1
      get edit_work_path(invalid_work_id)
      must_respond_with :not_found
    end
  end


  describe "update" do
    it "returns success if the work ID is valid and the change is valid" do
      work = Work.first
      work_data = {
        work: {
          title: "New title",
          creator: "New Creator"
        }
      }
      work.update_attributes(work_data[:work])
      work.must_be :valid?

      patch work_path(work), params: work_data

      must_respond_with :redirect
      must_redirect_to work_path

      # Check that the change went through
      work.reload
      work.title.must_equal work_data[:work][:title]
    end

    it "returns not_found if the book ID is invalid" do
      invalid_work_id = Work.last.id + 1
      work_data = {
        work: {
          title: "New title",
          creator: "New Creator"
        }
      }

      patch work_path(invalid_work_id), params: work_data

      must_respond_with :not_found
    end

    it "returns bad_request if the change is invalid" do
      work = Work.first
      invalid_work_data = {
        work: {
          title: ""
        }
      }
      # Check that the update is actually invalid
      work.update_attributes(invalid_work_data[:work])
      work.wont_be :valid?

      patch work_path(work), params: invalid_work_data

      must_respond_with :bad_request

      work.reload
      work.title.wont_equal invalid_work_data[:work][:title]
    end
  end

    describe "destroy" do
      it "returns success and destroys the book when given a valid book ID" do
        # Arrange
        work_id = Work.first.id

        # Act
        delete work_path(work_id)

        # Assert
        must_respond_with :redirect
        must_redirect_to works_path
        Work.find_by(id: work_id).must_be_nil
      end

      it "returns not_found when given an invalid book ID" do
        invalid_work_id = Work.last.id + 1

        start_work_count = Work.count

        delete work_path(invalid_work_id)

        must_respond_with :not_found
        Work.count.must_equal start_work_count
      end
    end
  end
