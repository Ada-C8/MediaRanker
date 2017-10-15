require "test_helper"

describe VotesController do
  let(:vote) { Vote.new }
  let(:one) { users(:one) }
  let(:two) { users(:two) }
  let(:album) { works(:album) }
  let(:book) { works(:book) }

  it "must create a vote with valid parameters when the user is logged in" do
    login_user_one
    proc {post create_vote_path(one.id, album.id)}.must_change 'Vote.count', +1
    must_respond_with :redirect
    flash[:success].must_equal "Successfully upvoted!"
  end

  it "must not create a vote when the user is not logged in" do
    post create_vote_path(one.id, album.id)
    Vote.count.must_equal 0
    flash[:error].must_equal "You must log in to do that"
  end

  it "must not create a vote with invalid parameters" do
    login_user_one
    post create_vote_path(two.id, album.id)
    Vote.count.must_equal 0
    flash[:error].must_equal "You must log in to do that"
    invalid_work_id = find_invalid_work_id
    post create_vote_path(one.id, invalid_work_id)
    Vote.count.must_equal 0
    flash[:error].must_equal "The vote was not valid"
  end

  it "must not create a vote when the vote is not unique" do
    login_user_one
    proc {post create_vote_path(one.id, album.id)}.must_change 'Vote.count', +1
    flash[:success].must_equal "Successfully upvoted!"
    post create_vote_path(one.id, album.id)
    Vote.count.must_equal 1
    flash[:error].must_equal "The vote was not valid"
  end

  def login_user_one
    post login_path, params: {username: one.username}
    session[:user_id].must_equal one.id
    flash[:success].must_equal "Successfully logged in as existing user #{one.username}"
  end

  def find_invalid_work_id
    existing_work_ids = Work.all.map {|work| work.id}
    invalid_work_id = 1
    invalid_work_id += 1 until !existing_work_ids.include?(invalid_work_id)
    return invalid_work_id
  end
end
