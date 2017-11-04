require "test_helper"

describe Vote do
  let(:vote) { Vote.new }


  # it "must be valid" do
  #   value(vote).must_be :valid?
  # end
  describe "relations" do
    it "relations to both work and user" do
      vote = votes(:vote1)

      # work relation
      vote.must_respond_to :work
      vote.work.must_be_kind_of Work

      # user relation
      vote.must_respond_to :user
      vote.user.must_be_kind_of User
    end
  end

  describe "validations" do
    let (:user1) { User.create!(name: 'angela') }
    let (:user2) { User.create!(name: 'angela') }
    let (:work1) { Work.create!(category: 'album', title: 'smells like teen spirit') }
    let (:work2) { Work.create!(category: 'album', title: 'blah') }

    it "work_id is present, vote is valid" do
      vote = votes(:vote1)
      vote.must_be :valid?
    end

    it "work_id is NOT present, invalid vote" do
      vote = Vote.new

      vote.valid?.must_equal false
      vote.errors.messages.must_include :work_id
    end

    it "user_id is NOT present, invalid vote" do
      vote = Vote.new(work_id: 1 )

      vote.valid?.must_equal false
      vote.errors.messages.must_include :user_id
    end

    it "allows user to vote for multiple works" do
      vote1 = Vote.new(user: user1, work: work1)
      vote1.save!
      vote2 = Vote.new(user: user1, work: work2)
      vote2.valid?.must_equal true
    end

    it "allows multiple users to vote for a work" do
      vote1 = Vote.new(user_id: user1.id, work_id: work1.id)
      puts vote1
      vote1.save!
      vote2 = Vote.new(user: user2, work: work2)
      vote2.valid?.must_equal true
    end

    it "user cannot double vote on a work" do
      vote1 =  votes(:vote1)

      # make another vote for the same work from same user.
      vote2 = Vote.create(user_id: users(:user1).id, work_id: works(:work1).id)
      # Prevent vote from being saved to database
      vote2.valid?.must_equal false
      # tell user they cannot vote on the same work

      vote2.errors.messages.must_include :user_id
    end
  end

  describe "make new vote" do
    it "Successfully make new vote" do
      # need user id so make a user
      user_id = User.create!(name: "angela").id
      puts user_id
      work_id = Work.create!(category: "album", title: "test").id


      start_count = Vote.all.count

      vote = Vote.create!(
        work_id: work_id,
        user_id: user_id
      )

      after_count = Vote.all.count

      vote.must_be_instance_of Vote
      after_count.must_equal start_count + 1
    end

    it "invalid " do

    end
  end
end
