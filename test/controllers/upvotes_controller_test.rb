require "test_helper"

describe UpvotesController do

  it "should create upvote" do
    post login_path, params: {name: users(:dex).name}
    proc { post upvote_path(works(:hp).id)}.must_change 'Upvote.count', 1
    must_respond_with :redirect
  end

  it "can't upvote more than once" do
    post login_path, params: {name: users(:dex).name}
    post upvote_path(works(:hp).id)
    proc { post upvote_path(works(:hp).id)}.must_change 'Upvote.count', 0
    must_respond_with :redirect
  end

  it "should can't upvote if not logged in" do
    proc { post upvote_path(works(:hp).id)}.must_change 'Upvote.count', 0
    must_respond_with :redirect
  end

end
