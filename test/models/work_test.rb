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
end
