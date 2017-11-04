require "test_helper"

describe Work do
  let(:work) { Work.new }

  describe "relations" do
    it "has many votes" do
      work =  Work.new(title: "test")
      work.must_respond_to :votes
    end
  end #end description

  describe "validations" do

    #for the following tests I understand the are 'wet' and could be DRYed. At the moment, I am focuesed on completing the assignment. If there is time I will go back and figure out how to utilize the DRYing method taught in class.
    it "create work with all fields" do
      work = Work.create!(
        category: "album",
        title: "test work",
        publication_year: 2017,
        description: "test",
        creator: "me",
      )

      work.must_be :valid?
    end

    it "requires category" do
      work = Work.new

      result = work.valid?
      result.must_equal false
      work.errors.messages.must_include :category
    end

    it "requires title" do
      work = Work.new

      result = work.valid?
      result.must_equal false
      work.errors.messages.must_include :title
    end
  end # end describe

  describe "custom methods" do
    it "spotlight returns highest media based of num votes" do
      Work.spotlight.title.must_equal "test_record"
    end

    it "spotlight returns 'no work' when no works are present" do
      Work.destroy_all

      Work.spotlight.must_equal nil
    end

    it "top_ten returns top_ten works for Album" do
      works = Work.top_ten("album")

      works.must_be_kind_of Array

      works.first.must_be_instance_of Work
      works.last.must_be_instance_of Work

      works.first.title.must_equal "test_record"
      works.last.title.must_equal "test_record"

      works.length.must_be :<=, 10
    end

    it "if no albums in db returns []" do
      Work.destroy_all

      work = Work.top_ten("album")
      work.must_equal []
    end

    it "top_ten returns top_ten works for movie" do
      #testing movie
      works = Work.top_ten("movie")

      works.must_be_kind_of Array

      works.first.must_be_instance_of Work
      works.last.must_be_instance_of Work

      works.last.title.must_equal "many"
      works.first.title.must_equal "indiana jones"

      works.length.must_be :<=, 10
    end

    it "if no movies in db returns []" do
      Work.destroy_all

      work = Work.top_ten("movie")
      work.must_equal []
    end

    it "top_ten returns top_ten works for book" do
      #testing book
      works = Work.top_ten("book")

      works.must_equal []
      works.length.must_be :<=, 10
    end
  end
end
