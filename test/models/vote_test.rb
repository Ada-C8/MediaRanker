require "test_helper"

describe Vote do
  let :user { users(:bennett) }
  let :work { works(:hp2) }
  let :vote { Vote.new(work: work, user: user)}

  describe "valiations" do
    it "is valid" do
      vote.must_be :valid?
    end

    it "isn't valid if no user_id" do
      v = Vote.new
      v.wont_be :valid?
      v.errors.messages.must_include :user_id
    end

    it "isn't valid if no work_id" do
      v = Vote.new
      v.wont_be :valid?
      v.errors.messages.must_include :work_id
    end

    it "isn't valid if user has voted before" do
      vote.save
      vote.wont_be :valid?
    end
  end

  describe "relationships" do
    it "has a user" do
      vote.must_respond_to :user
      vote.user.must_equal user
      vote.user_id.must_equal user.id
    end

    it "has a work" do
      vote.must_respond_to :work
      vote.work.must_equal work
      vote.work_id.must_equal work.id
    end
  end
end
