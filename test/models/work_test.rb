require 'test_helper'

describe Work do

  describe "validations" do
    it "must have a category to be valid" do
      foundation = works(:foundation)
      foundation.category = nil
      foundation.valid?.must_equal false

      foundation.category = "book"
      foundation.valid?.must_equal true
    end

    it "must have either book, movie or album as the category to be valid" do
      foundation = works(:foundation)
      foundation.category = "something new"
      foundation.valid?.must_equal false

      foundation.category = "album"
      foundation.valid?.must_equal true
    end

    it "must have a title to be valid" do
      hp = works(:harrypot)
      hp.title = nil
      hp.valid?.must_equal false
      hp.errors.messages.must_include :title
      hp.title = "Harry Potter!"
      hp.valid?.must_equal true
    end

    it "can add a work if the title doesn't already exist within the caegory" do
      hp_copycat = Work.new
      hp_copycat.category = "book"
      hp_copycat.title = "Harry Potter"
      hp_copycat.creator = "someone"
      hp_copycat.publication_year = 2016
      hp_copycat.description =  "Something"
      hp_copycat.valid?.must_equal false, "The title should be unique within its category"

      hp_copycat = Work.new
      hp_copycat.category = "album"
      hp_copycat.title = "Harry Potter"
      hp_copycat.creator = "someone"
      hp_copycat.publication_year = 2016
      hp_copycat.description =  "Something"
      hp_copycat.user_id =  users(:one).id
      hp_copycat.valid?.must_equal true
    end

    it "must have a creator to be valid" do
      traveller = works(:traveller)
      traveller.creator = nil
      traveller.valid?.must_equal false

      traveller.creator = "Lord Huron"
      traveller.valid?.must_equal true
    end

    it "must have a publication date to be valid" do
      traveller = works(:traveller)
      traveller.publication_year = nil
      traveller.valid?.must_equal false

      traveller.publication_year = 2003
      traveller.valid?.must_equal true
    end

    it "the publication date must be a positive integer of 4 numbers to be valid" do
      traveller = works(:traveller)

      traveller.publication_year = "two thousand twelve"
      traveller.valid?.must_equal false

      traveller.publication_year = "year"
      traveller.valid?.must_equal false

      traveller.publication_year = 230
      traveller.valid?.must_equal false

      traveller.publication_year = "-2016"
      traveller.valid?.must_equal false

      traveller.publication_year = "230a"
      traveller.valid?.must_equal false

      traveller.publication_year = "2023"
      traveller.valid?.must_equal false

      traveller.publication_year = 2003
      traveller.valid?.must_equal true
    end

    it "the publication date canno't be past the current date to be valid" do
      traveller = works(:traveller)
      traveller.publication_year = 2018
      traveller.valid?.must_equal false
      traveller.publication_year = 2017
      traveller.valid?.must_equal true
    end
  end

end
