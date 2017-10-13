require "test_helper"

describe User do
  let(:user) { User.new } 

  describe "validations" do

    it "can be created with all fields" do
      u = User.new(name: "new user")

      u.must_be :valid?
    end

    it "is invalid without a name" do
      result = user.valid?
      result.must_equal false
      user.errors.messages.must_include :name
    end

  end

  describe "relations" do
    it "responds to votes" do
      user.must_respond_to :votes
    end
  end

end
