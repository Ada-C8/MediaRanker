require "test_helper"

describe User do
  describe "validations" do
    it "is valid with a name" do
      u = users(:cheetara)
      result = u.valid?
      result.must_equal true
    end

    it "must have a name" do
      u = User.new
      result = u.valid?
      result.must_equal false
      u.errors.messages.must_include :name
    end
  end

  describe "relations" do
    it "must have votes" do
      u = users(:tygra)
      u.votes.count.must_equal 0
    end

    it "must have votes" do
      # u = User.new(name: "bob")
      u = users(:cheetara)
      u.votes.count.must_equal 2
    end
  end
end
