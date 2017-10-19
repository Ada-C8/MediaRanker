require './test/test_helper'

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
