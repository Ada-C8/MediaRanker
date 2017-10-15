require "test_helper"

describe UsersController do
  describe "index" do
    it "returns a success status for all works" do
      get users_path
      must_respond_with :success
    end #success1

    it "returns a success status when there are no users" do
      User.destroy_all
      get users_path
      must_respond_with :success
    end #success2
  end#index tests


  describe "new" do
    it "gets a new form" do
      get new_user_path
      must_respond_with :success
    end #get form
  end #new tests


  describe "create" do
    it "adds the User to the DB and redirects when the user data is valid" do
      # Arrange
      user_data = {
        user: {
          username: "Test Name"
        }
      }
      # Test data should result in a valid work, otherwise
      # the test is broken
      User.new(user_data[:user]).must_be :valid?

      start_user_count = User.count

      # Act
      post users_path, params: user_data

      # Assert
      must_respond_with :redirect
      must_redirect_to users_path

      User.count.must_equal start_user_count + 1
    end #adds work test

    it "sends bad_request when the user data is bogus" do
      # Arrange
      invalid_user_data = {
        user: {
          # NO TITLE!!!
          username: ""
        }
      }
      # Double check the data is truly invalid
      User.new(invalid_user_data[:user]).wont_be :valid?

      start_user_count = User.count

      # Act
      post users_path, params: invalid_user_data

      # Assert
      must_respond_with :bad_request
      # Vanilla rails doesn't provide any way to do this
      # assert_template :new
      User.count.must_equal start_user_count
    end #bad request
  end #create tests

  describe "show" do
    it "returns success when given a valid User ID" do
      # Arrange
      user_id = User.first.id

      # Act
      get user_path(user_id)

      # Assert
      must_respond_with :success
    end #success


    it "returns not_found when given an invalid user ID" do
      invalid_user_id = User.last.id + 1
      get user_path(invalid_user_id)
      must_respond_with :not_found
    end #invalid




  end #showtests
    describe "log in" do
      it "returns success when given a valid username" do
        # Arrange
        user_id = User.first.id
        # Act
        get login_path(user_id)

        # Assert
        must_respond_with :success
      end

      it "renders new form if no username is entered" do
        invalid_user_id = User.first.id + 1
        get login_path(invalid_user_id)
        must_respond_with :not_found
      end
    end



end #all tests


#
#   describe "update" do
#     it "returns success if the work ID is valid and the change is valid" do
#       work = Work.first
#       work_data = {
#         work: {
#           title: "New title",
#           creator: "New Creator"
#         }
#       }
#       work.update_attributes(work_data[:work])
#       work.must_be :valid?
#
#       patch work_path(work), params: work_data
#
#       must_respond_with :redirect
#       must_redirect_to work_path
#
#       # Check that the change went through
#       work.reload
#       work.title.must_equal work_data[:work][:title]
#     end
#
#     it "returns not_found if the book ID is invalid" do
#       invalid_work_id = Work.last.id + 1
#       work_data = {
#         work: {
#           title: "New title",
#           creator: "New Creator"
#         }
#       }
#
#       patch work_path(invalid_work_id), params: work_data
#
#       must_respond_with :not_found
#     end
#
#     it "returns bad_request if the change is invalid" do
#       work = Work.first
#       invalid_work_data = {
#         work: {
#           title: ""
#         }
#       }
#       # Check that the update is actually invalid
#       work.update_attributes(invalid_work_data[:work])
#       work.wont_be :valid?
#
#       patch work_path(work), params: invalid_work_data
#
#       must_respond_with :bad_request
#
#       work.reload
#       work.title.wont_equal invalid_work_data[:work][:title]
#     end
#   end
#
#     describe "destroy" do
#       it "returns success and destroys the book when given a valid book ID" do
#         # Arrange
#         work_id = Work.first.id
#
#         # Act
#         delete work_path(work_id)
#
#         # Assert
#         must_respond_with :redirect
#         must_redirect_to works_path
#         Work.find_by(id: work_id).must_be_nil
#       end
#
#       it "returns not_found when given an invalid book ID" do
#         invalid_work_id = Work.last.id + 1
#
#         start_work_count = Work.count
#
#         delete work_path(invalid_work_id)
#
#         must_respond_with :not_found
#         Work.count.must_equal start_work_count
#       end
#     end
#   end
