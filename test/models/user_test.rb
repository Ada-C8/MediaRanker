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
