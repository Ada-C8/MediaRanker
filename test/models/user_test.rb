require "test_helper"

describe User do

  describe "validations" do
    let(:user) { User.new }

    it "can be created with all fields" do
      u = User.new(name: "new user", joined: Date.new)

      u.must_be :valid?
    end

    it "is invalid without a name" do
      result = user.valid?
      result.must_equal false
      user.errors.messages.must_include :name
    end

    it "is invalid without a joined date" do
      result = user.valid?
      result.must_equal false
      user.errors.messages.must_include :joined
    end

  end

end
