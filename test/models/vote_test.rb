require "test_helper"

describe Vote do
  let(:vote) { Vote.new }

  describe "validations" do
    it "can created with all fields" do
      v = Vote.new(user_id: User.first.id, work_id: Work.first.id, voted_on: Date.today)

      v.must_be :valid?
    end

    it "is invalid without a user_id" do
      result = vote.valid?
      result.must_equal false
      vote.errors.messages.must_include :user_id
    end

    it "is invalid without a work_id" do
      result = vote.valid?
      result.must_equal false
      vote.errors.messages.must_include :work_id
    end

    it "is invalid without a voted_on value" do
      result = vote.valid?
      result.must_equal false
      vote.errors.messages.must_include :voted_on
    end
  end
end
