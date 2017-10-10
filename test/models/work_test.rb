require "test_helper"

describe Work do
  let(:dune) { works(:dune) }

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

  it "must have a publication year" do
    dune.publication_year = nil
    dune.valid?.must_equal false

    dune.publication_year = 1974
    dune.valid?.must_equal true
  end

  it "doesn't require a description" do
    dune.description = nil
    dune.valid?.must_equal true

    dune.description = "happy happy"
    dune.valid?.must_equal true
  end
end
