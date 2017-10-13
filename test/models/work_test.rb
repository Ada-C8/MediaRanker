require "test_helper"

describe Work do
  let(:work) { Work.new }
  let(:lemonade) { works(:lemonade)}
  let(:hellodolly) { works(:hellodolly)}
  let(:vote_a) { votes(:vote_a)}
  let(:vote_b) { votes(:vote_b)}
  let(:vote_c) { votes(:vote_c)}
  let(:user_a) { users(:user_a)}
  let(:user_b) { votes(:user_b)}

  describe "validations" do
    it "is not valid without a title and author" do
      work.valid?.must_equal false
    end

    it "is invalid without additional attributes" do
      Work.create.errors[:title].any?.must_equal true
    end

    it "requires both a title and category to be created" do
      work.title = "Gone With The Wind"
      work.save
      work.valid?.must_equal false
      work.errors[:category].must_include "can't be blank"
      work.category = "movie"
      # puts work.errors[:category]
      work.valid?.must_equal true
    end

    it "must have a unique title and must return a specific error when someone tries to make a duplicate title" do
      lemonade.valid?.must_equal true
      work.title = "Lemonade"
      work.category = "album"
      work.save.must_equal false
      work.errors.keys.must_include :title
      work.errors[:title].must_include "has already been taken"
    end

    it "must only accept the 3 set values for category (doesn't accept music as category)" do
      lemonade.valid?.must_equal true
      work.title = "Lemonade"
      work.category = "music"
      work.save.must_equal false
      work.errors.keys.must_include :category
      work.errors[:category].must_include "music is not a valid input for category. Accepts categories movie, book, or album"
    end

  end

  describe "relations" do

  end

  describe "custom methods" do

    it "calculates total votes" do
      #our votes fixture file shows 3 votes for lemonade (1 is invalid [vote_duplicate], and not brought in via the "let" above)
      lemonade.total_votes(lemonade.id).must_equal 3
      hellodolly.total_votes(hellodolly.id).must_equal 1


    end
  end

end
