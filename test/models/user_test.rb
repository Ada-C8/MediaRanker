require "test_helper"

describe User do
  let :user {users(:one) }

  describe "validations" do
    it "should be valid" do
      user.must_be :valid?
    end

    it "requires a username" do
      user1 = User.new
      is_valid = user1.valid?
      is_valid.must_equal false
      user1.errors.messages.must_include :username
    end

    it "requires a unique username" do
      username = "user1"
      u1 = User.login!(username: username)
      u2 = User.login_form(username: username)

      u2.wont_be :valid?
    end
  end

  describe "relationships" do
    it "can have a vote" do
      user.must_respond_to :votes
    end
  end
end
