require "test_helper"


# -At least one test, as many as are required, for any custom method
# -At least one test, usually just one, for each relationship
# -At least 2 tests for each validation (failure case/success case)
# -At least 2 tests for each scope

describe Vote do
  let(:vote) { Vote.new }

  describe "validations" do
      it "can be created with all fields" do
        u = User.create!
        c = "Movie"
        w = Work.new(category: c, title: "test work")
        v = Vote.new(user_id: u.id, work_id: w.id)
        b.must_be :valid?
      end

      it "requires a user_id" do
        v = Vote.new
        is_valid = v.valid?
        is_valid.must_equal false
        v.errors.messages.must_inlcude :user_id
      end
    end

    describe "relations" do

      it "has a one user" do
        v = Vote.new
        v.must_respond_to :users
        v.users.must_be :empty

        u = User.create!(name: "Diane")
        v.users  << u
        v.users.must_include u
      end

      it "has a one work" do
        v = Vote.new
        v.must_respond_to :works
        v.works.must_be :empty

        w = Work.create!(category: "Movie", title: "Stick It")
        v.users  << u
        v.users.must_include u
      end

    end
end
