require "test_helper"

describe HomeController do

  describe 'home' do
    it 'gives home page aka root path ' do
      get root_path
      must_respond_with :success
    end

    it 'should return success with NO works in database' do
      Work.destroy_all
      get root_path
      must_respond_with :success
    end
  end
end
