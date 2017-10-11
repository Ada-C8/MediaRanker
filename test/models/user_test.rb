require "test_helper"

describe User do
  let(:user) { users(:one) }

  describe "validations" do
    it "can be created with all fields" do
      u = User.new
      u.username = "FirstUserEver"

      u.must_be :valid?
    end

    it "as a username" do
      user.username.must_equal "Owly"
    end
  end # Describe

end # Describe
