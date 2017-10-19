require "./test/test_helper"
require 'date'

=begin
Read model ID from URL - 2 cases
-valid ID
-invalid ID

controller reads data and adds to DB - 2
-data was valid
-data failed validations

reads data from session - 2 cases
-user logged in
-user not logged in

=end

describe SessionsController do

  describe 'validations' do
    it "user is logged in" do
      get login_path, params:{
        user: {
          name: 'john'
        }
      }
      must_respond_with :success
    end

    it "user is logged out" do
      get login_path, params:{
        user: {
          name: 'john'
        }
      }

      get logout_path, params:{
        user:{
          name: 'john'
        }
      }
      must_redirect_to root_path
    end


  end




end
