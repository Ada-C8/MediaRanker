require "test_helper"

describe Work do
  let(:greys) {works(:greys)}
  let(:work) {Work.new}

  it "must have a title and category to be true" do
    greys.valid?.must_equal true
  end

  it "will not be true unless it has a title and category" do
    greys.title = nil
    greys.valid?.must_equal false;

    greys.title = "Grey's Anatomy"
    greys.category = nil
    greys.valid?.must_equal false;
  end

  it "will be valid if it has either a unique title or the same title with a unique category" do
    work.title = "Grey's Anatomy"
    work.category = "music"
    work.valid?.must_equal true
    greys.valid?.must_equal true
  end

  it "a work will not be valid if it has the same title and category " do
    work.title = "Grey's Anatomy"
    work.category = "screen"
    work.valid?.must_equal false
  end

  
end
