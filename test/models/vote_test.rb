require "test_helper"

describe Vote do
  let(:vote) { Vote.new }
  let(:vote1) { votes(:vote1) }
  let(:user3) { users(:user3) }
  let(:movie) { works(:movie1) }
  let(:movie2) { works(:movie2) }

  describe "relationships" do
    it 'can set the user through "user"' do
      vote1.user = user3

      vote1.user_id.must_equal user3.id
    end

    it 'can set the user through "user_id"' do
      vote1.user_id = user3.id

      vote1.user.must_equal user3
    end

    it 'can set the work through "work"' do
      vote1.work = movie

      vote1.work_id.must_equal movie.id
    end

    it 'can set the work through "work_id"' do
      vote1.work_id = movie.id

      vote1.work.must_equal movie
    end
  end #Relationships

  describe "validations" do
    it "must have a User to be valid" do
      #false
      vote.work = movie
      vote.valid?.must_equal false

      #true
      vote.user = user3
      vote.valid?.must_equal true
    end

    it "must have a Work to be valid" do
      #false
      vote.user = user3
      vote.valid?.must_equal false

      #true
      vote.work = movie
      vote.valid?.must_equal true
    end

    it "must have a unique User in relation to its Work to be valid" do
      # false
      vote.user = vote1.user
      vote.work = vote1.work

      vote.valid?.must_equal false

      #true - different user
      vote.user = User.new(username: "A Name")
      vote.valid?.must_equal true

      #true - different work
      vote.user = vote1.user
      vote.work = movie2

      vote.valid?.must_equal true

    end

  end # validations set
end
