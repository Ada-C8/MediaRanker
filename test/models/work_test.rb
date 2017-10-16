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

  it "can return a list of works ordered by vote, #self.sort" do
    greatest = Work.sort[0]
    second = Work.sort[1]
    greatest.title.must_equal "Grey's Anatomy"
    second.title.must_equal "Harry Potter"
    greatest.votes.count.must_equal 2
    second.votes.count.must_equal 1
  end

  it "can return the 'featured' work by returning the work with the greatest vote count, #self.top" do
    top = Work.top
    top.title.must_equal "Grey's Anatomy"
  end

  it "will only return one featured work, even if there are two works with the same number of votes" do
    Vote.new(user: users(:west), work: works(:hp))
    Work.top.must_equal works(:greys)


  end


end
