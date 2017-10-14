require "test_helper"


# -At least one test, as many as are required, for any custom method
# -At least one test, usually just one, for each relationship
# -At least 2 tests for each validation (failure case/success case)
# -At least 2 tests for each scope

describe Vote do
  let(:vote) { Vote.new }

  describe "validations" do
      it "can be created with all fields" do
        u = User.create!(name: "lain")
        w = Work.create!(category: "Movie", title: "test work")
        v = Vote.create(user_id: u.id, work_id: w.id)
        v.must_be :valid?
      end

      it "requires a user_id" do
        v = Vote.new
        is_valid = v.valid?
        is_valid.must_equal false
        v.errors.messages.must_include :user
      end
    end

    # describe "relationships" do
    #
    #   it "has a one user" do
    #     w = Work.create!(category: "Movie", title: "Stick It")
    #     v = Vote.new(work_id: w)
    #     v.must_respond_to :user
    #     v.user_id.must_equal nil
    #
    #     u = User.create!(name: "Diane")
    #     v.user_id = u
    #     v.user.must_equal u
    #   end
    #
    #   it "has a one work" do
    #     v = Vote.create
    #     v.must_respond_to :work
    #     v.work_id.must_be nil
    #
    #     w = Work.create!(category: "Movie", title: "Stick It")
    #     v.user_id = w
    #     v.user.must_equal w
    #   end
    #
    # end
end
