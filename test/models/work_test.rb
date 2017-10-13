require 'test_helper'

describe Work do
  let(:work) { Work.new }

  describe 'validations' do
    it "must have a title to be valid" do
      work.category = "book"
      work.valid?.must_equal false
      work.title = "The Great Gatsby"
      work.valid?.must_equal true
    end

    it "must have a category to be valid" do
      work.title = "The Great Gatsby"
      work.valid?.must_equal false
      work.category = "book"
      work.valid?.must_equal true
    end

    it "must have a unique creator and title combination" do
      work.category = "book"
      work.title = "Grapes of Wrath"
      work.creator = "John Steinbeck"
      work.valid?.must_equal false

      work.title = "East of Eden"
      work.valid?.must_equal true
    end

    it "if a year is provided, it must be a 4-digit number" do
      work.category = "movie"
      work.title = "Practical Magic"
      work.valid?.must_equal true
      work.publication_year = 98
      work.valid?.must_equal false
      work.publication_year = "fweik3un"
      work.valid?.must_equal false
      work.publication_year = 1998
      work.valid?.must_equal true
    end
  end


end
