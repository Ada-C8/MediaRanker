# require "test_helper"
#
# describe Work do
#   let :work { Work.first }
#   describe "validations" do
#     it "can be created with all fields" do
#       w = Work.new(title: "test book", creator: "sa", publication_year: 1986, category: "book", description: "good book")
#
#       w.must_be :valid?
#     end
#
#     it "requires a title" do
#       w = Work.new
#       is_valid = w.valid?
#       is_valid.must_equal false
#       w.errors.messages.must_include :title
#     end
#
#     it "requires a unique title" do
#       title = "test book"
#       w1 = Work.create!(title: title, creator: creator, publication_year: publication_year, category: category)
#       w2 = Work.new(title: title, creator: creator, publication_year: publication_year, category: category)
#
#       w2.wont_be :valid?
#     end
#   end
# end
