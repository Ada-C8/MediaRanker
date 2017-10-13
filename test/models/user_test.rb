require "test_helper"

describe User do
  let(:user) { User.new }

  it "must be valid" do
    user.name = "Averi"
    value(user).must_be :valid?
  end

  it "is invalid without a name" do
    user.valid?.must_equal false
    user.name = ""
    user.valid?.must_equal false
  end

  it "has relations" do
    works = users(:averi).upvotes
    works[0].id.must_equal upvotes(:one).id
  end
end
