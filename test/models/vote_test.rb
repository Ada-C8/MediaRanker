require "test_helper"

describe Vote do
  let(:user) { User.first }
  let(:vote) { Vote.first }
  let(:work) { Work.first }

  describe "validations" do
    it "can be created with all fields" do
      v = Vote.new(
        user_id: user.id,
        work_id: work.id,
      )
      v.must_be :valid?
    end
  end

  describe "relations" do
    it "has a user_id" do
      v = votes(:vote)
      # u = users(:one)
      v.must_respond_to :user
      # v.user_id.must_equal u
    end

    it "has a work_id" do
      v = votes(:vote)
      w = works(:album)
      v.must_respond_to :work
      # v.work_id.must_equal w.id
    end
  end
end
