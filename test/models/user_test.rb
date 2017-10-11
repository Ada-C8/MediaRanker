require "test_helper"

describe User do
  let(:user) { users(:one) }

  describe "validations" do
    it "can be created with all fields" do
      u = User.new(name: "FirstUserEver")

      u.must_be :valid?
    end

    it "has a username" do
      user.name.must_equal "Owly"
    end

    it "should be invalid if username is blank" do
      u = User.new

      u.valid?.must_equal false
      u.errors.messages.must_include :name
    end

  end # Describe

end # Describe
