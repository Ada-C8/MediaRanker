require "test_helper"

describe User do

  describe "validations" do

    it "must have a username to be valid" do
      user = users(:user1)
      user.username = nil
      user.valid?.must_equal false

      user.username = "Marcel"
      user.valid?.must_equal true
    end

    it "must have an username that doesn't already exist to be valid" do
      user = users(:user1)
      name = user.username
      new_user = User.new
      new_user.username = name
      new_user.valid?.must_equal false
    end

  end
end
