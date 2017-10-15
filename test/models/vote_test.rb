require "test_helper"

describe Vote do
  let :user { User.first }
  let :work { Work.first }
  let :vote { Vote.new(work: work, user: user) }

  describe "validations" do
    it "must be valid, created with all fields" do
      vote.must_be :valid?
    end

    it "isn't valid with out user_id" do
      v = Vote.new
      v.wont_be :valid?
      v.errors.messages.must_include :user_id
    end

    it "isn't valid with out work_id" do
      v = Vote.new
      v.wont_be :valid?
      v.errors.messages.must_include :work_id
    end

    it "is invalid if the user_id and work_id are not unique" do
      vote.save
      v = Vote.new(work: work, user: user)
      v.wont_be :valid?
      v.errors.messages.must_include :user_id

    end
  end

  describe "relations" do
    it "responds to user" do
      vote.must_respond_to :user
    end

    it "responds to work" do
      vote.must_respond_to :work
    end
  end

  # describe "methods" do
  # end
end
