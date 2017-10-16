require "test_helper"

describe User do
  describe "validations" do
    it "can be created with all fields" do
      u = User.new(name: "new_user", join_date: Date.today)
      u.must_be :valid?
    end

    it "requieres a name" do
      u=User.new
      is_valid = u.valid?
      is_valid.must_equal false
      u.errors.messages.must_include :name
    end
  end

  describe "ralations" do
    it 'can set the vote' do
      w = works(:work1)
      u = users(:user1)
      u.must_respond_to :votes
      u.votes.count.must_equal 0
      v = Vote.create!(work_id: w.id, user_id: u.id)
      u.votes.count.must_equal 1
    end
  end
end
