require "test_helper"

describe VotesController do
  before do
    # log in user
    @user = users(:harry)
    post login_path(user: {name: @user.name})
  end

  # can't redirect and return status other then 30x so this test won't pass
  # it "returns unauthorized if user isn't logged in" do
  #   post logout_path
  #
  #   # confirm logged out
  #   session[:user_id].must_be_nil
  #
  #   post upvote_work_path(works(:dune))
  #   must_respond_with :unauthorized
  # end
  # REPLACEMENT TEST for above
  it "redirects to previous page if user isn't logged in" do
    # if redirecting from works#index
    from_works_page = { HTTP_REFERER: "/works" }
    post logout_path

    # confirm logged out
    session[:user_id].must_be_nil

    post upvote_work_path(works(:dune)), headers: from_works_page

    must_respond_with :redirect
    must_redirect_to works_path
  end

  it "returns bad request if work doesn't exist" do
    invalid_id = Work.last.id + 1

    # if logged in
    session[:user_id].must_equal @user.id

    post upvote_work_path(invalid_id)
    must_respond_with :bad_request

    # if not logged in
    post logout_path
    session[:user_id].must_be_nil

    post upvote_work_path(invalid_id)
    must_respond_with :bad_request

  end

  it "returns bad request if user has already upvoted the work" do
    # find work user already voted for
    upvoted_work = @user.votes[0]
    start_count = Vote.count

    post upvote_work_path(upvoted_work)

    must_respond_with :bad_request
    Vote.count.must_equal start_count
  end

  it "must respond with redirect if user upvotes work" do
    start_count = Vote.count

    post upvote_work_path(works(:dune))

    must_respond_with :redirect
    Vote.count.must_equal start_count + 1
  end

end
