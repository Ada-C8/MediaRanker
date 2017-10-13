require "test_helper"

describe Vote do
  let(:vote) { Vote.new }
  let(:vote_a) { votes(:vote_a)}
  let(:vote_b) { votes(:vote_b)}
  let(:vote_duplicate) {votes(:vote_duplicate)}
  let(:user_a) { users(:user_a)}
  let(:user_b) { votes(:user_b)}
  let(:hellodolly) { works(:hellodolly)}
  let(:lemonade) { works(:lemonade)}

  describe "validations" do

    it "requires a user_id and work_id to be valid" do
      test_vote = Vote.new
      test_vote.valid?.must_equal false
      test_vote.errors.keys.must_include :user_id
      test_vote.errors[:user_id].must_include "can't be blank"
      test_vote.errors.keys.must_include :work_id
      test_vote.errors[:work_id].must_include "can't be blank"
    end

    # it "unique votes- requires the same user_id and work_id cannot be associated in more than 1 vote instance" do
    #   work = Work.new
    #   work.title = "Lemonade"
    #   work.category = "album"
    #   user = User.new
    #   user.name = "Mary Poppins"
    #   vote = Vote.new(work: work, user: user)
    #   vote.save.must_equal false
    #   puts "PRY--------------"
    #   binding.pry
    #   vote.errors.keys.must_include :user_id
    #   vote.errors[:user].messages.must_include "duplicate vote record; a vote record must be unique (a user cannot vote for the same work twice)"

      it "unique votes- requires the same user_id and work_id cannot be associated in more than 1 vote instance" do
        vote_duplicate.valid?.must_equal false
        # vote_duplicate.errors.keys.must_include :user_id
        # vote_duplicate.errors[:user].must_include "duplicate vote record; a vote record must be unique (a user cannot vote for the same work twice)"
    end
  end

  describe "relations" do
    it "responds to and accesses user_id and work_id" do
      vote_a.must_respond_to :user_id
      vote_a.user_id.must_equal user_a.id

      vote_a.must_respond_to :work_id
      vote_a.work_id.must_equal works(:hellodolly).id
    end

  end

  describe "custom methods" do
    #none yet
  end

end
