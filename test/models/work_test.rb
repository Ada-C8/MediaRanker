require "test_helper"

# describe Work do
#   let(:work) { Work.new }
#
#   it "must be valid" do
#     value(work).must_be :valid?
#   end
# end

describe "validations" do
  it "requires a title" do
    w = Work.new
    w.wont_be :valid?
    w.errors.messages.must_include :title
  end

  it "can be created with all fields" do
    w = Work.new(category: "category", title: "title", creator: "creator", publication_year: 2000, description: "some description")
    w.must_be :valid?
  end

  it "requires a category" do
    w = Work.new
    w.wont_be :valid?
    w.errors.messages.must_include :category
  end
end
