require "test_helper"

describe Work do
  let(:work) { Work.new }

  it "must be valid" do
    value(work).must_be :valid?
  end

  # the work must have:
    # a category,
    # title,
    # creator,
    # publication_year,
    # description,
    # and ability to save/create.

  it "requires a category" do
    work = Work.new
    is_valid = work.valid?
    is_valid.must_be false

    work.errors.messages.must_include :category

  end

  it "requires a title " do # why is there only one test?
    work = Work.new
    is_valid = work.valid?
    is_valid.must_equal false #why is it false, copied from the books example
    work.errors.messages.must_include :title
  end


end
