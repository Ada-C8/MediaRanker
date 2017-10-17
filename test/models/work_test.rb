require "test_helper"

describe Work do
  let(:work) { Work.new }

  let(:book1) { works(:book1) }

  it "must have a title to be valid" do
    book1.valid?.must_equal true
    book1.title = nil
    book1.valid?.must_equal false
  end


end
