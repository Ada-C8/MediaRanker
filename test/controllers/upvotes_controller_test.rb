require "test_helper"

describe UpvotesController do
  # it "should get create" do
  #   get upvotes_create_url
  #   value(response).must_be :success?
  # end

  it "should create upvote" do
    proc {
      post upvote_path(works(:hp).id), params: {session: {user_id: users(:dex).id}}
    }.must_change 'Upvote.count', 1
    must_respond_with :redirect
  end

end
