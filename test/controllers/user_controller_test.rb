require "./test/test_helper"
require 'date'
require './app/helpers/application_helper'

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

describe UsersController do
  it "must get index page" do
    get users_path
    must_respond_with :success
  end

  describe 'user id validations' do
    it "get specified valid user" do
      get users_path(users(:one).id)
      must_respond_with :success
    end

    it "get specified invalid user" do
      get user_path(-1)
      must_respond_with :missing
    end
  end

  describe 'Make new user' do
    it 'will create a valid new user' do
      post users_path, params: {
        user: {
          name: 'john',
          joined_on: Date.today
        }
      }
      must_respond_with :redirect
      must_redirect_to root_path
    end
  end

  describe 'testing custom functions' do
    it 'test find_user' do
      t = ApplicationHelper.find_user(users(:one).id)
      t.must_equal 'john'
    end

    it 'test votes_for_work' do
      work = Work.find(1)
      t = ApplicationHelper.votes_for_work(work)
      t.must_be_kind_of Integer
    end

    it 'tests top_10' do
      result = ApplicationHelper.top_10('album')
      result.must_be_kind_of Array
    end

    it 'tests user_cast_votes' do
      user = User.find(1)
      result = ApplicationHelper.user_cast_votes(user)
      result[0].must_be_kind_of Vote
    end

    it 'test get_title from ID' do
      work = Work.find(1)
      result = ApplicationHelper.get_title(1)
      result.must_equal work.title

    end

    it 'test get_published ' do
      work = Work.find(1)
      result = ApplicationHelper.get_published(1)
      result.must_equal work.published
    end

    it 'test get_creator' do
      work = Work.find(1)
      result = ApplicationHelper.get_creator(1)
      result.must_equal work.creator
    end
  end

end
