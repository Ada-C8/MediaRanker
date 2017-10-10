require "test_helper"

describe UserController do
  it "should get index" do
    get user_index_url
    value(response).must_be :success?
  end

end
