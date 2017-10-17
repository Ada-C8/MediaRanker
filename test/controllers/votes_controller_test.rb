require "test_helper"

describe VotesController do
  it "should get index" do
    get votes_index_url
    value(response).must_be :success?
  end

  it "should get upvote" do
    get votes_upvote_url
    value(response).must_be :success?
  end

end
