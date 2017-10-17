require "test_helper"

describe Vote do
  let(:vote) { Vote.new }

  describe "validations" do
    it "must not be valid without a user_id nor a work_id" do
      vote.valid?.must_equal false
    end

    it "must not be valid without a user_id, even if it has a work_id" do
      w = Work.create!(title: "Of Mice and Men")
      v = Vote.new(work_id: w.id)
      is_valid = v.valid?
      is_valid.must_equal false
    end

    it "must not be valid without a work_id, even if it has a user_id" do
      u = User.create!(name: "Selina Kyle", join_date: DateTime.now)
      v = Vote.new(user_id: u.id)
      is_valid = v.valid?
      is_valid.must_equal false
    end

    it "must be valid with both a user_id and a work_id" do
      u = User.create!(name: "Selina Kyle", join_date: DateTime.now)
      w = Work.create!(title: "Of Mice and Men")
      v = Vote.new(user_id: u.id, work_id: w.id)

      is_valid = v.valid?
      is_valid.must_equal true
    end
  end # end validations tests

  describe 'relations' do
    it 'responds to user' do
      vote.must_respond_to :user
    end

    it 'responds to work' do
      vote.must_respond_to :work
    end

  end # end relations tests
end
