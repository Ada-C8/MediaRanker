require "test_helper"

describe Vote do
  let(:user2) { users(:user2) }
  let :work { Work.first }
  let :vote { Vote.new(work: work, user: user2) }

  describe "validations" do
    it "must be valid" do
      vote.must_be :valid?
    end

    it "needs a user_id" do
      test = Vote.new(work: work)
      test.wont_be :valid?
    end

    it "needs a work_id" do
      test = Vote.new(user: user2)
      test.wont_be :valid?
    end
  end

  describe "its relationships to works/users" do
    it "talks to work" do
      vote.must_respond_to :work
    end

    it "talks to user" do
      vote.must_respond_to :user
    end
  end
end
