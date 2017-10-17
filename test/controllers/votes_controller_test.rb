require "test_helper"

describe VotesController do

  it "will create an upvote given work and user login" do
    user = users(:user_two)
    work = works(:album_one)

    post login_path, params: {username: user.username}

    proc { post upvote_path(work.id)}.must_change 'Vote.count', 1
    must_respond_with :redirect

  end

  it "user can't vote for same work twice" do
    user = users(:user_two)
    work = works(:album_one)

    post login_path, params: {username: user.username}

    post upvote_path(work.id)

    proc { post upvote_path(work.id)}.must_change 'Vote.count', 0
    must_respond_with :redirect

  end
  
  it "will not create an upvote if not logged in" do
    work = works(:album_one)

    proc { post upvote_path(work.id)}.must_change 'Vote.count', 0
    must_respond_with :redirect

  end

end
