require "test_helper"

describe User do
  describe 'validations' do
    it "is valid with a name" do
      u = User.new(name: "bob")
      result = u.valid?
      result.must_equal true
    end

    it "must have a name" do
      u = User.new
      result = u.valid?
      result.must_equal false
    end
  end

  describe 'relationships' do
    it "must have votes" do
      u = User.new(name: "bob")
      u.votes.count.must_equal 0
    end

  end
end
