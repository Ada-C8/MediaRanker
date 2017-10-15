require "test_helper"

describe Work do
  let(:work) { Work.new }
  let(:almost) { works(:almost) }
  let(:gatsby) { works(:gatsby) }
  let(:thriller) { works(:thriller) }

  it "must have category to be valid" do
    almost.valid?.must_equal true
    almost.category = nil
    almost.valid?.must_equal false
  end

  it "must have title to be valid" do
    almost.valid?.must_equal true
    almost.title = nil
    almost.valid?.must_equal false
  end

  it "must have creator to be valid" do
    almost.valid?.must_equal true
    almost.creator = nil
    almost.valid?.must_equal false
  end

  it "must have publication year to be valid" do
    almost.valid?.must_equal true
    almost.publication_year = nil
    almost.valid?.must_equal false
  end

  it "must have a publication year that is a number" do
    almost.valid?.must_equal true
    almost.publication_year = "yellow"
    almost.valid?.must_equal false
  end
  
  it "must have publication year must be greater than 0" do
    almost.valid?.must_equal true
    almost.publication_year = -1
    almost.valid?.must_equal false
    almost.publication_year = 0
    almost.valid?.must_equal false
  end


end
