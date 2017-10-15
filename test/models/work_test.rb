require "test_helper"

# describe Work do
#   let(:work) { Work.new }
#
#   it "must be valid" do
#     value(work).must_be :valid?
#   end
# params.require(:work).permit(:category, :title, :creator, :publication_year, :description)

describe Work do
  let :work{ Work.first }
  describe "validations" do
    it "can be created with all fields" do
      b = Work.new(category: "Album", title: "testing", creator: "Fake Creator", publication_year: 1999, description: "A Good Album")
      b.must_be :valid?
    end # validations

    it "requires a title" do
      b = Work.new
      is_valid = b.valid?
      is_valid.must_equal false
      b.errors.messages.must_include :title
    end #require title

    it "requires a unique title" do
      title = "test book"
      b1 = Work.create!(title: title)
      b2 = Work.new(title: title)

      b2.wont_be :valid?
    end #uniqueness
  end #work do

    describe "description" do
      it "rejects descriptions longer than 200 chars" do
        desc = "a" * 201
        b = Work.new(title: "Fake Title", description: desc)

        # b.wont_be :valid?
        is_valid = b.valid?
        is_valid.must_equal false

        b.errors.messages.must_include :description
      end

      it "allows descriptions <= 200 chars" do
        descriptions = [
          "a" * 199,
          "a" * 10,
          "a" * 0
        ]

        descriptions.each do |desc|
          b = Work.new(title: "test", description: desc)
          b.must_be :valid?
        end
      end
    end



  # describe "relations" do
  #   it "has an author" do
  #     b = books(:poodr)
  #     a = authors(:metz)
  #
  #     binding.pry
  #
  #     b.must_respond_to :author
  #     b.author.must_equal a
  #     b.author_id.must_equal a.id
  #   end
#
#     it "has a collection of genres" do
#       b = Book.new
#       b.must_respond_to :genres
#       b.genres.must_be :empty?
#
#       g = Genre.create!(name: "test genre")
#       b.genres << g
#       b.genres.must_include g
#     end
#   end
#
#   describe "age" do
#   end
end #all tests
