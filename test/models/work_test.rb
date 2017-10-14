require "test_helper"

describe Work do
  describe 'validations' do

    it "must be valid" do
      work = works(:relaxer)
      work.valid?.must_equal true
    end

    it 'must have a title' do
      work = Work.new
      work.valid?.must_equal false
    end

    it "requires a category " do
      work = Work.new(title: "WAT?", publication_year: 2017, creator: "Me")
      work.save.must_equal false
    end

    it "can create only allowed category names " do
      work = Work.new(category: "blurb", title: "WAT?", publication_year: 2017, creator: "Me")
      work.save.must_equal false
      work.errors.messages[:category].must_equal ["is not included in the list"]
    end

    it "must have a creator " do
      work = Work.new(category: "book", title: "WAT?", publication_year: 2017)
      work.save.must_equal false
      work.errors.messages[:creator].must_equal ["can't be blank"]
    end
  end
end
