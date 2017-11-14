require "test_helper"

describe "MediaInstancesController" do
  # it "must be a real test" do
  #   flunk "Need real tests"
  # end
  describe "index" do
    it "returns a success status for all media_instances" do
      get media_instances_path :media_type => "music"
      must_respond_with :success
    end

    it "returns a success status when there are no media_instances" do
      MediaInstance.destroy_all

      get media_instances_path :media_type => "music"
      must_respond_with :success
    end

    it "returns a success status when given a valid user_id and media_type" do
      get media_instance_path(:id => MediaInstance.first.id, :media_type =>MediaInstance.first.media_type)
      must_respond_with :success
    end

    it "returns something when given a bogus user_id" do
      bad_user_id = User.last.id + 1
      get user_media_instances_path(bad_user_id)
      must_respond_with :not_found
    end
  end

  describe "new" do
    it "works with an user id" do

      get new_media_instance_path({title: "The Giver", media_type: "book", user: User.first.id})
      must_respond_with :success
    end

    it "works without an user id" do
      get new_media_instance_path({title: "The Giver", media_type: "book"})
      must_respond_with :success
    end
  end

  describe "create" do
    it "adds the media_instance to the DB and redirects when the media_instance data is valid" do
      # Arrange
      media_instance_data = {
        media_instance: {
          media_type: "Test media_instance",
          title: "a title"
        }
      }

      # Test data should result in a valid media_instance, otherwise
      # the test is broken

      MediaInstance.new(media_instance_data[:media_instance]).must_be :valid?
      start_media_instance_count = MediaInstance.count


      # Act
      post media_instances_path, params: media_instance_data

      # Assert
      must_respond_with :redirect
      must_redirect_to media_instances_path

      MediaInstance.count.must_equal start_media_instance_count + 1
    end

    it "sends bad_request when the media_instance data is bogus" do
      # Arrange
      invalid_media_instance_data = {
        media_instance: {
          media_type: "book",
          # NO TITLE!!!
          user_id: User.first.id
        }
      }
      # Double check the data is truly invalid
      MediaInstance.new(invalid_media_instance_data[:media_instance]).wont_be :valid?

      start_media_instance_count = MediaInstance.count

      # Act
      post media_instances_path, params: invalid_media_instance_data

      # Assert
      must_respond_with :bad_request
      # Vanilla rails doesn't provide any way to do this
      # assert_template :new
      MediaInstance.count.must_equal start_media_instance_count
    end
  end

  describe "show" do
    it "returns success when given a valid media_instance ID" do
      # Arrange
      media_instance_id = MediaInstance.first.id

      # Act
      get media_instance_path(:id => media_instance_id, :media_type => "book")

      # Assert
      must_respond_with :success
    end

    it "returns not_found when given an invalid media_instance ID" do
      invalid_media_instance_id = MediaInstance.last.id + 1
      get media_instance_path(:id => invalid_media_instance_id, :media_type => "book")
      must_respond_with :not_found
    end
  end

  describe "edit" do
    it "returns success when given a valid media_instance ID" do
      # Arrange
      media_instance_id = MediaInstance.first.id

      # Act
      get edit_media_instance_path(media_instance_id)

      # Assert
      must_respond_with :success
    end

    it "returns not_found when given an invalid media_instance ID" do
      invalid_media_instance_id = MediaInstance.last.id + 1
      get edit_media_instance_path(invalid_media_instance_id)
      must_respond_with :not_found
    end
  end

  describe "update" do
    it "returns success if the media_instance ID is valid and the change is valid" do
      media_instance = MediaInstance.first
      media_instance_data = {
        media_instance: {
          title: "Changed title",
          media_type: "book",
          user_id: media_instance.user_id
        }
      }
      media_instance.update_attributes(media_instance_data[:media_instance])
      media_instance.must_be :valid?

      patch media_instance_path(id: media_instance, media_type: media_instance.media_type), params: media_instance_data

      must_respond_with :redirect
      must_redirect_to media_instance_path(media_instance)

      # Check that the change went through
      media_instance.reload
      media_instance.title.must_equal media_instance_data[:media_instance][:title]
    end

    it "returns not_found if the media_instance ID is invalid" do
      invalid_media_instance_id = MediaInstance.last.id + 1
      media_instance_data = {
        media_instance: {
          title: "Changed title",
          media_type: "book",
          user_id: User.first.id
        }
      }

      patch media_instance_path(invalid_media_instance_id, media_instance_data[:media_instance][:media_type]), params: media_instance_data

      must_respond_with :not_found
    end

    it "returns bad_request if the change is invalid" do
      media_instance = MediaInstance.first
      invalid_media_instance_data = {
        media_instance: {
          title: ""
        }
      }
      # Check that the update is actually invalid
      media_instance.update_attributes(invalid_media_instance_data[:media_instance])
      media_instance.wont_be :valid?

      patch media_instance_path(media_instance, media_type: "book"), params: invalid_media_instance_data

      must_respond_with :bad_request

      media_instance.reload
      media_instance.title.wont_equal invalid_media_instance_data[:media_instance][:title]
    end
  end

  describe "destroy" do
    it "returns success and destroys the media_instance when given a valid media_instance ID" do
      # Arrange
      media_instance_id = MediaInstance.first.id
      media_instance_type = MediaInstance.first.media_type

      # Act
      delete media_instance_path(id: media_instance_id, media_type: media_instance_type)

      # Assert
      must_respond_with :redirect
      must_redirect_to media_instances_path
      media_instance.find_by(id: media_instance_id).must_be_nil
    end

    it "returns not_found when given an invalid media_instance ID" do
      invalid_media_instance_id = MediaInstance.last.id + 1

      start_media_instance_count = MediaInstance.count

      delete media_instance_path(id: invalid_media_instance_id, media_type: "book")

      must_respond_with :not_found
      MediaInstance.count.must_equal start_media_instance_count
    end
  end

  describe "get movies" do
    it "works" do
      get movies_path
      must_respond_with :success
    end
    it "gives instances of movies" do
      get movies_path
      @movies
    end
  end

  describe "get books" do
    it "gives instances of books" do

    end

  end
  describe "get music" do
    it "gives instances of music" do

    end
  end

end
