require "test_helper"

describe User do

  describe "valiations" do
    it "is valid" do
      u = User.new(name: "Dan")
      u.must_be :valid?
    end

    it "isn't valid if no name, or empty string" do
      u = User.new
      u.wont_be :valid?

      u.name = ""
      u.wont_be :valid?
      u.errors.messages.must_include :name
    end

  end

  describe "relationships" do
    it "can have a vote" do
      u = User.new(name: "Dan")
      u.must_respond_to :votes
    end
  end
end
