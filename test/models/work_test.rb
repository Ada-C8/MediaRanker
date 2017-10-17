require "test_helper"

describe Work do
  let(:work) { Work.new }

  it "must have a title" do
    work.valid?.must_equal false
  end

  it "can create a new work" do
    work = Work.new(category: "movie", title: "Jaws")
    work.valid?.must_equal true
  end

  #need to figure out how to test custom methods
end
