require "test_helper"

describe Work do
  let :category { "album" }
  let :title { "test name" }

  describe "validations" do
    it "is valid" do
      w = Work.create!(category: category, title: title)
      w.must_be :valid?
    end

    it "isn't valid with out a title" do
      w = Work.new
      w.wont_be :valid?
      w.errors.messages.must_include :title
    end

    it "isn't valid with out a category" do
      w = Work.new
      w.wont_be :valid?
      w.errors.messages.must_include :category
    end
  end

  describe "relations" do
    it "responds to vote" do
      w = Work.new(title: "test")
      w.must_respond_to :votes
    end
  end

  describe "custom methods" do
    let :sorted_albums {sorted_albums = Work.sorted_works("album")}
    describe "sorted_works" do
      it "returns work of the specified category" do
        sorted_albums.each do |work|
          work.category.must_equal "album"
        end
      end

      it "returns works in order votes in descending order" do
        sorted_albums.first.votes.count.must_be :>, sorted_albums.second.votes.count
        sorted_albums.second.votes.count.must_be :>, sorted_albums.last.votes.count
      end

      it "Wont return anything if the category isn't a string matching on of the three categories 'album', 'book', or 'movie'" do
        Work.sorted_works(1).must_equal []
        Work.sorted_works(:cow).must_equal []
        Work.sorted_works("albums").must_equal []
        Work.sorted_works([1,2]).must_equal []
        Work.sorted_works(2.3).must_equal []
      end
    end

    describe "top_ten_works" do
      it "it will return up to ten works" do
        Work.top_ten_works("album").length.must_be :<=, 10
      end
    end
    
    describe "top_work" do
      it "finds the most voted for work" do
        # In fixtures made sure that the top work was the album "discovery"
        Work.top_work.title.must_equal "Discovery"
      end
    end
  end
end
