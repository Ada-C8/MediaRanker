require "test_helper"

describe VotesController do
  def login
    valid_params = {}
    valid_params[:user] = {name: "koko the gorilla"}
    post login_url, params:{user:{name: "koko the gorilla"}}
  end

  describe "create" do
    it "must not create a new vote if the user is not logged on" do
      work = works(:one)
      before_count = Vote.count
      post work_votes_path(work)
      flash[:status].must_equal :failure
      flash[:message].must_equal "You must be logged in to do that"
      before_count.must_equal Vote.count
    end

    it "must create a new vote if the user is logged in and has not voted on that work" do
      login
      work = works(:one)
      before_count = Vote.count
      post work_votes_path(work)
      flash[:status].must_equal :success
      flash[:message].must_equal "Succesfully upvoted"
      Vote.count.must_equal (before_count + 1)
    end

    it "must not create a new vote if the user has already logged on that work" do
      login
      work = works(:one)
      before_count = Vote.count
      post work_votes_path(work)
      post work_votes_path(work)
      flash[:status].must_equal :failure
      flash[:message].must_equal "user has already voted for this work"
      Vote.count.must_equal (before_count + 1)


    end
  end
end
