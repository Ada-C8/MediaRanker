require "test_helper"

describe User do
  describe "validations" do
    it "must be valid, created with all fields" do
      u = User.new(username: "test")
      u.must_be :valid?
    end

    it "isn't valid with out a name" do
      u = User.new(username: "")
      u.wont_be :valid?
      u.errors.messages.must_include :username
    end

    it "must have a unique name"do
      # create a user
      u = User.new(username: "test")
      u.save
      # make a new user with same username
      v = User.new(username: "test")
      v.wont_be :valid?
      v.errors.messages.must_include :username
    end
  end

  describe "relations" do
    it "responds to vote" do
      u = User.new(username: "test")
      u.must_respond_to :votes
    end
  end

  # describe "methods" do
  # end
end
