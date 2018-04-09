require "test_helper"

describe Work do
  let(:work) { Work.new }
  let(:twilight) { works(:twilight) }
  let(:harry_potter) { works(:harry_potter) }
  let(:fanPerson) { users(:fanPerson) }
  let(:one) { votes(:one) }

  it "must have a category" do
    twilight.valid?.must_equal true
    twilight.category = nil
    twilight.valid?.must_equal false
    twilight.errors[:category].must_equal ["can't be blank"]
  end

  it "must have a title" do
    harry_potter.valid?.must_equal true
    harry_potter.title = nil
    harry_potter.valid?.must_equal false
    harry_potter.errors[:title].must_equal ["can't be blank"]
  end

  it "can't have two works with same title and same category" do
    duplicate_book = Work.new(category: "book", title: "Harry Potter", publication_year: 1998)
    duplicate_book.save
    duplicate_book.valid?.must_equal false
  end

  it "same title different category is ok" do
    book_to_movie = Work.new(category: "movie", title: "Harry Potter", publication_year: 1998)
    book_to_movie.save
    book_to_movie.valid?.must_equal true
  end

  it "can find the single work with the most votes" do
    vote_count = Vote.count
    vote = Vote.new(user_id: users(:fanPerson).id, work_id: twilight.id)
    vote.save
    winner = Work.winner
    winner.id.must_equal twilight.id
    winner.votes.size.must_equal (vote_count + 1)
  end

  it "top ten finds fewer than 10 works if there are not 10" do
    top_books = Work.top_ten("book")
    top_books.size.must_equal 2
  end

  it "can find the top ten works by category" do
    10.times do |i|
      Work.create(category: "book", title: "#{i} book", publication_year: 2000)
    end
    top_books = Work.top_ten("book")
    top_books.size.must_equal 10
    top_books.first.title.must_equal "Twilight"
  end

  it "top_ten generates works even when no works in category have any votes" do
    10.times do |i|
      Work.create(category: "movie", title: "#{i} book", publication_year: 1998)
    end
    top_books = Work.top_ten("movie")
    top_books.size.must_equal 10
    top_books.first.votes.count.must_equal 0
  end

end
