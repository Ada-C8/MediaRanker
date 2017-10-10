require "test_helper"

describe User do
  describe "validations" do
    it "can be created and is valid" do
      u = User.new(username: "test")
      u.must_be :valid?
    end

    it "isn't valid without a name" do
      u = User.new(username: "")
      u.wont_be :valid?
    end

    # it "must be valid" do
    #   value(user).must_be :valid?
    # end
    #
    # it "isn't valid with out" do
    # end
  end

  describe "relations" do
    # it "responds to vote" do
    #   user = User.new(username: "test")
    #   user.must_respond_to :vote
    # end
  end

  describe "methods" do
  end
end
