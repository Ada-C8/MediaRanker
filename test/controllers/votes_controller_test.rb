require "test_helper"
# class SessionsControllerTest < ActionDispatch::IntegrationTest

describe VotesController do

  before do
    @work = Work.new(category: "book", title: "title", creator: "creator")
    @work.save
  end

  describe "#upvote" do
    it "returns a redirect_to the works_path" do
      post upvote_path(@work.id)
      must_respond_with :redirect
      must_redirect_to works_path
    end

    #PROBLEM: how to test which page a user is coming from?
      it "returns a redirect_to the works_path, if user is coming from works_path page" do
      end

      it "returns a redirect_to the work_path(work.id), if user is coming from work_path(work.id)" do
      end

    #PROBLEM: Can't get this test to work. Unable to set session in controller test.
    #Tried a few things, including having class SessionsControllerTest < ActionDispatch::IntegrationTest
    #Without being able to set session, I can only test the failure case when a user is not logged in

    # it "saves a new vote to the database when a user is logged in" do
    #   vote_count = Vote.count
    #
    #   work = Work.new(category: "book", title: "title", creator: "creator")
    #   work.save
    #   user = User.new(name: "name")
    #   user.save
    #
    #   # post upvote_path(work.id), session: { :logged_in_user => user.id }
    #   post :upvote, session: { :logged_in_user => user.id }
    #
    #   Vote.count.must_equal vote_count + 1
    # end

    it "sets a flash variable to be equal to :failure and the message to indicate to the user must be logged in to vote" do
      post upvote_path(@work.id)
      flash[:status].must_equal :failure
      flash[:message].must_equal "You must be logged in to vote"
    end
  end
end
# end
