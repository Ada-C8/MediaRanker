require "test_helper"

describe Work do
  let(:dune) { works(:dune) }

  describe "validations" do
    it "must have a title" do
      dune.title = nil
      dune.valid?.must_equal false

      dune.title = "Dune"
      dune.valid?.must_equal true
    end

    it "must have a creator" do
      dune.creator = nil
      dune.valid?.must_equal false

      dune.creator = "Frank Herbert"
      dune.valid?.must_equal true
    end

    it "doesn't require a publication year" do
      dune.publication_year = nil
      dune.valid?.must_equal true

      dune.publication_year = 1974
      dune.valid?.must_equal true
    end

    it "doesn't require a description" do
      dune.description = nil
      dune.valid?.must_equal true

      dune.description = "happy happy"
      dune.valid?.must_equal true
    end

    describe "validating publication_year" do
      it "can't have a publication year later than this year" do
        dune.publication_year = 2020
        dune.valid?.must_equal false

        dune.publication_year = 1974
        dune.valid?.must_equal true
      end

      it "must have a numerical publication year" do
        dune.publication_year = "apple"
        dune.valid?.must_equal false

        dune.publication_year = 1974
        dune.valid?.must_equal true
      end
    end

    describe "validating uniqueness of medium-specific work" do
      it "can't have a work with the same author and title in the same medium" do
        # byebug
        new_work = Work.new(title: dune.title, creator: dune.creator, publication_year: 2000, category_id: dune.category_id, description: "duplicate work")

        new_work.valid?.must_equal false
        new_work.category_id = categories(:album).id
        new_work.valid?.must_equal true
      end
    end

  end

  describe "relations" do
    let(:cat) { categories(:misc) }
    let(:new_work) { Work.new(creator: "Anon", title: "New Work") }

    it "can set the category through 'category'" do
      new_work.category = cat
      new_work.category_id.must_equal cat.id
    end

    it "can set the category through 'category_id'" do
      new_work.category_id = cat.id
      new_work.category.must_equal cat
    end
  end


end
