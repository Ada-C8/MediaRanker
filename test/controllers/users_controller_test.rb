require "test_helper"

describe UsersController do
  let :user_data {
    user_data = {
      user: {
        username: "Sarah"
      }
    }
  }
  let :invalid_user_data {
    invalid_user_data = {
      user: {
        username: ""
      }
    }
  }
  let :user_id { User.last.id }

  describe "index" do
    it " " do

    end
  end

  describe "new" do

  end
  # # Arrange
  # # Act
  # # Assert
  describe "create" do

  end
  # # Arrange
  # # Act
  # # Assert
  describe "show" do

  end
  # # Arrange
  # # Act
  # # Assert
  describe "edit" do

  end

  describe "update" do

  end

  describe "destroy" do

  end

end
