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

  describe "custom method" do
    it "#vote creates a Vote" do
      work = works(:work1)
      user = users(:user1)

      user.vote(work).must_be_instance_of Vote
    end

    it "#vote fails if work id is not present" do
      work = Work.new
      user = User.create(name: "name")
      # puts user

      vote = user.vote(work)
      vote.must_equal "must have work id"
    end
  end
end
