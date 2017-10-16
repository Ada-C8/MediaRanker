require './test/test_helper'

class UserTest < ActiveSupport::TestCase

    test "make new user" do
      user = User.new
      result = user.valid?
      result.must_equal false
    end

end
