require "test_helper"

describe Work do
  let :work { Work.first }

  describe 'relationship' do
    it " should respond to vote " do
      w = Work.new(title: "test book")
      w.must_respond_to :votes
    end
  end

  describe "validations" do
    it "can be created with all fields" do
      w = Work.new(title: "test book", creator: "sa", publication_year: 1986, category: "book", description: "good book")

      w.must_be :valid?
    end

    it "requires a title" do
      w = Work.new
      w.valid?.must_equal false
      w.errors.messages.must_include :title
    end

    it "requires a unique title" do
      title = "test_book"
      w1 = Work.create!(title: title)
      w2 = Work.new(title: title)

      w2.wont_be :valid?
    end
  end

  describe "work_with_the_most_votes" do
    it "can find the work with the most votes" do
      res = Work.work_with_the_most_votes
      expected = Work.find_by_title("Countdown to Ecstasy")
      res.must_equal expected
    end

    it "can find top 3 works with most votes in album" do
      res = Work.top_n_in_category(:album, 3)
      res.must_include Work.find_by_title("Countdown to Ecstasy")
      res.must_include Work.find_by_title("Countdown to Ecstasy 2")
      res.must_include Work.find_by_title("Countdown to Ecstasy 4")
      res.size.must_equal 3
    end

    it "can find top 3 in movies" do
      res = Work.top_n_in_category(:movie, 10)
      res.must_include Work.find_by_title("Jurassic_Park")
      res.size.must_equal 1
    end

    it "returns all works ordered by vote count" do
      res = Work.all_with_vote_count
      expected = [
        Work.find_by_title("Countdown to Ecstasy"),
        Work.find_by_title("Countdown to Ecstasy 2"),
        Work.find_by_title("Countdown to Ecstasy 4"),
        Work.find_by_title("Jurassic_Park"),
        Work.find_by_title("Countdown to Ecstasy 3"),
        Work.find_by_title("Harry Potter")]
        res.must_equal expected
        res.size.must_equal 6
      end

    end
  end
