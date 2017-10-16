require './test/test_helper'

class WorkControllerTest < ActionDispatch::IntegrationTest

  test "should get work index" do
    get works_url
    assert_response :success
  end

  test "can see welcome page" do
    get '/'
    assert_select
  end

end
