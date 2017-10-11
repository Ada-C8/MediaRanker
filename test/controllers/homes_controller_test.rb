require "test_helper"

describe HomesController do
  it "should get index" do
    get homes_index_url
    value(response).must_be :success?
  end

end
