require "test_helper"

describe Vote do
  let :movie { works(:movie) }
  let :user { users(:one) }
  let :vote { Vote.new(movie: work, user: user)}


  describe "validations" do
    it "requires user_id" do
      b = Vote.new
      b.wont_be :valid?
      b.errors.messages.must_include :user_id
    end

    it "requires work_id" do
      b = Vote.new
      b.wont_be :valid?
      b.errors.messages.must_include :work_id
    end
  end
end
