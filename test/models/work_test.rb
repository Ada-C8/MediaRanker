require "test_helper"

# Write at least one test for each custom method on a model
# Write at least one test for each model relationship on a model
# Write at least two tests for each validation on a model

describe Work do
  let(:work) { Work.new }

  it "must have a title and category to be valid" do
    work.valid?.must_equal false
    work.errors.keys.must_include :title
    work.title = "The Great Gatsby"
    work.save

    work.errors.keys.must_include :category
    work.valid?.must_equal false
    work.category = "book"
    work.save

    work.valid?.must_equal true
  end

  it "must have a unique title within one category" do
    work.title = "Hello World!"
    work.category = "movie"
    work.save

    other_work = Work.new
    other_work.title = "Hello World!"
    other_work.category = "movie"
    other_work.save
    other_work.errors.keys.must_include :title
    other_work.errors[:title].must_equal ["This work already exists"]

    #can save it to another category
    other_work.category = "book"
    other_work.save
    other_work.valid?.must_equal true
  end

  it "must have a positive 4 digit number as a publication_year" do
    new_work = works(:poodr)

    # Can't take strings
    new_work.publication_year = "not a number"
    new_work.save
    new_work.errors.keys.must_include :publication_year

    # Can't take negatives
    new_work.publication_year = -10
    new_work.save
    new_work.errors.keys.must_include :publication_year

    # Can't take positive integers below 1000
    new_work.publication_year = 999
    new_work.save
    new_work.errors.keys.must_include :publication_year
  end

  it "must have 'Anonymous' set if creator's value is not set" do
    works(:no_creator).creator.must_equal "Anonymous"
  end

end
