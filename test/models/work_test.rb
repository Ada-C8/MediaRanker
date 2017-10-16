require "test_helper"

describe Work do
  let(:work) { Work.new }
  let(:twilight) { works(:twilight) }
  let(:harry_potter) { works(:harry_potter) }
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
    duplicate_book = Work.new(category: "book", title: "Harry Potter")
    duplicate_book.save
    duplicate_book.valid?.must_equal false
  end

  it "same title different category is ok" do
    book_to_movie = Work.new(category: "movie", title: "Harry Potter")
    book_to_movie.save
    book_to_movie.valid?.must_equal true
  end

  # TODO NEED TO FINISH THESE TWO TESTS
  it "can find the single work with the most votes" do
    puts "TOTAL VOTES!!! #{twilight.votes.size}"
    fanPerson = User.new({name: "fanPerson"})
    vote = Vote.new(user_id: fanPerson.id, work_id: twilight.id)
    vote.save
    puts "TOTAL VOTES!!! #{twilight.votes.size}"

    winner = Work.winner
    winner.id.must_equal twilight.id
    winner.votes.size.must_equal 3


  end

  it "can find the top ten works by category" do


  end

end
