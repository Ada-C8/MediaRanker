require "test_helper"

describe User do
  let(:user) { User.new }

  describe "validations" do
    it "can be created with a name" do
      u = User.new(name: "name")
      u.must_be :valid?
    end

    it "requires a name" do
      u = User.new
      is_valid = u.valid?
      is_valid.must_equal false
      u.errors.messages.must_include (:name)
    end
  end

  describe "relations" do
    #user has_many vote
    it "must respond to vote" do
      u = User.new(name: "name")
      u.must_respond_to :vote
    end
  end

  # describe "custom methods" do
  #
  # end

end
