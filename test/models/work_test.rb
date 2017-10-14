require "test_helper"

describe Work do
  let(:work) { works(:one) }

  it "must be valid" do
    value(work).must_be :valid?
  end

  it "Should require a category" do
    work.category = nil
    work.valid?.must_equal false
  end

  it "Should require a title" do
    work.title = nil
    work.valid?.must_equal false
  end

  it "Should require a creator" do
    work.creator = nil
    work.valid?.must_equal false
  end

end
