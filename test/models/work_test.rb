require "test_helper"

describe Work do
  let(:work) { Work.new }
  it "must have a title to be valid" do
    work = works(:chansons)
    work.valid?.must_equal true
    work.title = nil
    work.valid?.must_equal false
  end

  it "must have an creator to be valid" do
    work = works(:chansons)
    work.valid?.must_equal true
    work.creator = nil
    work.valid?.must_equal false

    # book.price.must_be :<, 5, "The price must be less than $5"
  end
end
