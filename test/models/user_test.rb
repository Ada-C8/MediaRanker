require "test_helper"

describe User do
  describe "validations" do
    it "can be created with a name" do
      u = users(:tanja)
      u.valid?.must_equal true
    end

    it "must have a name" do
      u = User.new
      u.valid?.must_equal false
    end

    it "name must be valid" do
      u = users(:tanja)
      u.valid?.must_equal true
    end

    it "name must be unique" do
      u = users(:tanja)
      u.save.must_equal true

      clone = User.new(name: u.name)

      clone.save.must_equal false
      clone.errors.messages[:name].must_equal ["has already been taken"]
    end

  end

  describe "relationships" do
    it "can access votes" do
      u = users(:tanja)
      u.votes.count.must_equal 2
      # I have set up 2 fixtures for votes
    end

  end
end
