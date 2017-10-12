require "test_helper"

describe Vote do
  let(:harry_vote) { votes(:one) }
  let(:hermione_vote) { votes(:two) }

  describe "validations" do
    it "must be valid" do
      harry_vote.valid?.must_equal true
    end

    it "must only allow one vote per work per user" do
      dup_vote = Vote.new(user_id: users(:harry).id, work_id: works(:hp).id)
      dup_vote.valid?.must_equal false

      dup_vote.work_id = works(:dune).id
      dup_vote.valid?.must_equal true
    end
  end

  describe "relations" do
    let(:vote_with_user) { Vote.new(user_id: users(:harry).id) }

    let(:vote_with_work) { Vote.new(work_id: works(:dune).id) }

    it "can set the work through 'work'" do
      vote_with_user.work = works(:dune)
      vote_with_user.work_id.must_equal works(:dune).id
    end

    it "can set the work through 'work_id'" do
      vote_with_user.work_id = works(:dune).id
      vote_with_user.work.must_equal works(:dune)
    end

    it "can set the user through 'user'" do
      vote_with_work.user = users(:harry)
      vote_with_work.user_id.must_equal users(:harry).id
    end

    it "can set the user through 'user_id'" do
      vote_with_work.user_id = users(:harry).id
      vote_with_work.user.must_equal users(:harry)
    end
  end


end
