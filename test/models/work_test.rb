require "test_helper"

describe Work do
  let(:work) { Work.new }
  let(:gatsby) { works(:gatsby) }

  it "must have a category to be valid" do
    work.title = "title"
    work.valid?.must_equal false
    work.category = "category"
    work.valid?.must_equal true
  end

  it "must have a title to be valid" do
    work.category = "category"
    work.valid?.must_equal false
    work.title = "title"
    work.valid?.must_equal true
  end

  it "must have a unique title to be valid" do
    work.category = "category"
    work.title = "The Great Gatsby"
    work.valid?.must_equal false
    work.title = "Uniquest Book Ever"
    work.valid?.must_equal true
  end

  it "must have a collection of associated votes" do
    its_votes = Vote.where(work_id: gatsby.id)

    its_votes.length.must_equal 2
    its_votes[0].must_be_instance_of Vote
  end
end
