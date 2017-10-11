require "test_helper"

describe UpvotesController do
  it "should get create" do
    get upvotes_create_url
    value(response).must_be :success?
  end

end
