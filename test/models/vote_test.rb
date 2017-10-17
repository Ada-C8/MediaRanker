require "test_helper"
require 'date'
#
# describe Vote do
#   let(:vote) { Vote.new }
#
#   it "must be valid" do
#     value(vote).must_be :valid?
#   end
# end

describe Vote do
  before do
    @u = users(:tanja)
    @w = works(:cat_stevens)
  end

  describe "validations" do

    it "can be created with a name and work" do
      v = Vote.new(user_id: @u.id, work_id: @w.id)
      v.valid?.must_equal true
    end

    it "must have a user_id" do
      v = Vote.new(work_id: @w.id)
      v.valid?.must_equal false
    end

    it "must have a work_id" do
      v = Vote.new(user_id: @u.id)
      v.valid?.must_equal false
    end
  end

  describe "fixtures" do
    it "can access fixtures" do
      votes(:vote1).wont_be_nil
    end
  end

  describe "created at" do
    it "records and reports the correct date vote made" do
      new_user = User.create!(name: "patrick")
      new_vote = Vote.create!(user_id: new_user.id, work_id: @w.id)
      new_vote.valid?
      new_vote.created_at.to_date.must_equal DateTime.now.utc.to_date
    end
end

  describe "votes_by_user" do
    it "gives a list of votes for only the user specified" do
      Vote.votes_by_user(@u).count.must_equal 1
    end
    it "works when user has no votes" do
      new_user = User.create!(name: "jack")
      new_user.valid?
      Vote.votes_by_user(new_user).count.must_equal 0
    end
    it "reports the correct work title" do
      work_id = Vote.votes_by_user(@u)[0].work_id
      work = Work.find_by(id: work_id)
      work.title.must_equal "Cats in the Cradle"
    end

  end

end
