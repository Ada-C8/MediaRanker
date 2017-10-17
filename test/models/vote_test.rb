require "test_helper"

describe Vote do
  let(:w) { Work.first }
  let(:u) { User.new(name: "Mira") }
  let(:v) { Vote.new(user_id: u.id) }

  describe "relationships" do
    it "belongs to a user" do
      v.user = u
      v.must_respond_to :user
      v.user.must_equal u
      v.user_id.must_equal u.id
    end # it "belings to a user" do

    it "belongs to a work" do
      v.must_respond_to :work
      v.work = w
      v.work.must_equal w
      v.work_id.must_equal w.id
    end # it "belongs to a work" do
  end # describe "relationships" do

  describe "validations" do
    it "can be created with all fields" do
      # TODO: is it ok that I have to save u to make this test pass?
      u.save
      v = Vote.new(user_id: u.id, work_id: w.id)
      v.must_be :valid?
    end # it "can be created with all fields" do

    # NOTE: don't worry about testing this! we will learn this type of testing later
    # it "will allow a user to vote for a work once (will create the vote the first time)" do
    #   u = User.first
    #
    #   numer_of_votes_by_user = u.votes.count
    #   numer_of_votes_by_user.must_equal 0
    #
    #   u.votes.create(user_id: u.id, work_id: w.id)
    #
    #   # must_respond_with :redirect
    #   # must_redirect_to works_path
    #   u.votes.count.must_equal numer_of_votes_by_user + 1
    # end # allow the user to vote the first time
    #
    # it "will stop the user from voting more than once for a work" do
    # end # can't vote more than once
  end # describe "validations" do
end # Vote do
