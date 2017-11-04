require "test_helper"

describe User do
  let(:user) { User.new }

  # it "must be valid" do
  #   value(user).must_be :valid?
  # end

  describe "relations" do
    it "has a list of votes" do
      user = users(:user1)
      user.must_respond_to :votes
      user.votes.each do |vote|
        vote.must_be_kind_of Vote
      end
    end
  end

  describe "validations" do
    it "requires a name" do
      user = User.new
      user.valid?.must_equal false
      user.errors.messages.must_include :name
    end
  end
end
