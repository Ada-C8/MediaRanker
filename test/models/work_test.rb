require "test_helper"

describe Work do
  let(:work) { Work.new }
  let(:work2) { Work.create(title: "Hello") }

  it "is invalid without a title" do
    work.valid?.must_equal false
    work.errors.messages.must_include :title
  end
  it "must have a title to be valid" do
    work.valid?.must_equal false
    work.title = "Title"
    work.valid?.must_equal true
  end
  it "is invalid when title is not unique" do
    work2.valid?.must_equal true
    work.title = "Hello"
    work.valid?.must_equal false
    work.errors.messages.must_include :title
  end
  it "must have a unique title" do
    work2.valid?.must_equal true
    work.title = "Hello2"
    work.valid?.must_equal true
  end
end
