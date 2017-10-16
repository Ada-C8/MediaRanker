require "test_helper"

describe User do
  let(:user) { User.new }

  let(:jane) { users(:jane) }

  it "is invalid without a username" do
    result = jane.valid?
    result.must_equal true

    result = user.valid?
    result.must_equal false

    user.errors.messages.must_include :username
  end

  describe 'relations' do

    it "User can vote on a work" do

    end

    it "User's ID is used when counting votes" do
      user_votes = users(:jane).votes
      user_votes.first.id.must_equal votes(:first).id
    end

    it "User can only vote on a work once" do
      

    end

  end
end
