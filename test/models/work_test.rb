require "test_helper"

describe Work do
  let(:work) { Work.new }

  it "is invalid without a title" do
    work.valid?.must_equal false
    work.errors.messages.must_include :title
  end
  it "must have a title to be valid" do
    work.valid?.must_equal false
    work.title = "Title"
    work.valid?.must_equal true
  end
end
