require "test_helper"

describe User do
  describe "validations" do
    it "can be created with name field" do
      u = User.new(name: "test user")
      u.must_be :valid?
    end

    it "requires a name" do
      u = User.new
      is_valid = u.valid?
      is_valid.must_equal false
      u.errors.messages.must_include :name
    end
  end
end
