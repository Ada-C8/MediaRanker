require "test_helper"
require 'pry'

describe Vote do
  before do
    @vote = Vote.new
    # Create two models
    @work = works(:movie_one)
    @user = users(:user_one)
  end

  it 'is valid if it has a user and work' do
    first_vote = votes(:vote_one)
    (first_vote.valid?).must_equal false

    first_vote.user = @user
    first_vote.work = @work

    first_vote.must_be :valid?
  end

  describe 'relations' do

    it 'can set the work and author through "work" and "author"' do

      # Make the models relate to one another
      @vote.work = @work
      @vote.user = @user

      # author_id should have changed accordingly
      ((@vote.work).id).must_equal @work.id
      ((@vote.user).username).must_equal @user.username

      @vote.must_be :valid?
    end

    it 'can set the work and user through "work_id" and "user_id"' do


      # Make the models relate to one another
      @vote.user_id = @user.id
      @vote.work_id = @work.id

      # author should have changed accordingly
      @vote.user.must_equal @user
      @vote.work.must_equal @work

      @vote.must_be :valid?
    end
  end
end
