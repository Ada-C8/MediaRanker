require "test_helper"

describe Vote do
  let(:vote) { votes(:vote1)}

  it 'must have a user_id to be valid' do
    vote.valid?.must_equal true

    vote.user_id = nil
    vote.valid?.must_equal false
  end

  it 'must have a work_id to be valid' do
    vote.valid?.must_equal true

    vote.work_id = nil
    vote.valid?.must_equal false
  end
  it "must respond to user_id" do
    user = users(:gale)

    vote.user_id.must_equal user.id
    User.find(vote.user_id).username.must_equal 'galestorm'
  end

  it "must respond to work_id" do
    work = works(:gatsby)

    vote.work_id.must_equal work.id
    Work.find(vote.work_id).title.must_equal 'The Great Gatsby'
  end
end
