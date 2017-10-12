require "test_helper"

describe User do
  describe "validations" do
    it "can be created with a name" do
      u = User.new(name: "Tanja")
      u.valid?.must_equal true
    end

    it "must have a name" do
      u = User.new
      u.valid?.must_equal false
    end
  end

  describe "relationships" do
    it "can access votes" do
      u = User.new(name: "Tanja")
      u.votes.count.must_equal 0
    end
  end
end
