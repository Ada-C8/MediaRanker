require "test_helper"

describe Vote do
  it "is valid if it has a user_id and work_id" do
    vote = Vote.create!(user_id: users(:test_user).id, work_id: works(:test_book).id)
    vote.valid?.must_equal true
  end

  it "is not valid if it is missing a work_id" do
    vote = Vote.new
    vote.user_id = users(:test_user).id
    vote.save
    vote.valid?.must_equal false

    vote.work_id = works(:test_book).id
    vote.save
    vote.valid?.must_equal true
  end

  it "is not valid if it is missing a user_id" do
    vote = Vote.new
    vote.work_id = works(:test_book).id
    vote.save
    vote.valid?.must_equal false

    vote.user_id = users(:test_user).id
    vote.save
    vote.valid?.must_equal true
  end

  it "assigns a vote to a work" do
    work = Work.create!(category: "book", title: "This is a book", creator: "An author")
    vote = Vote.new(user_id: users(:test_user).id, work_id: work.id)
    vote.save
    work.votes.count.must_equal 1
  end
end
