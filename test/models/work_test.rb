require "test_helper"

describe Work do
  let(:work) { Work.new }
  let(:movie) { works(:movie) }
  let(:album) { works(:album) }
  let(:book) { works(:book) }
  let(:user) { users(:one) }

  it "requires a title and a creator to be valid" do
    work.valid?.must_equal false
    work.title = "A title"
    work.valid?.must_equal false
    work.title = nil
    work.creator = "A creator"
    work.valid?.must_equal false
    work.title = "A title"
    work.valid?.must_equal true
  end

  it "requires a unique set of category, title, and creator to be valid" do
    hp_book = Work.new(category: 'book', 'title': "Harry Potter", creator: "JK Rowling")
    hp_book.save.must_equal true
    another_hp_book = Work.new(category: 'book', 'title': "Harry Potter", creator: "JK Rowling")
    another_hp_book.valid?.must_equal false
    another_hp_book.title = 'Harry Potter and the Chamber of Secrets'
    another_hp_book.valid?.must_equal true
    hp_movie = Work.new(category: 'movie', 'title': "Harry Potter", creator: "JK Rowling")
    hp_movie.valid?.must_equal true
    hp_new_author = Work.new(category: 'book', 'title': "Harry Potter", creator: "Robert Galbraith")
    hp_new_author.valid?.must_equal true
  end

  it "can find the unique categories using get_categories()" do
    categories = Work.get_categories()
    categories.must_equal ['album', 'book', 'movie']
  end

  it "can find the top works for each category using get_top_works(categories)" do
    works = [album, book, movie]
    categories = Work.get_categories()
    # top_works should not be empty when no works have any votes
    top_works = Work.get_top_works(categories)
    i = 0
    top_works.values.each do |value|
      value.must_equal [works[i]]
      i +=1
    end
    # top_works should contain Work objects when works have votes
    works.each do |a_work|
      (1..100).to_a.each do |j|
        Work.create(title: "#{j}", creator: "a creator", category: a_work.category)
      end
      Vote.create(user_id: user.id, work_id: a_work.id)
    end
    top_works = Work.get_top_works(categories)
    i = 0
    top_works.values.each do |value|
      value.length.must_equal 10
      value.must_include works[i]
      i+= 1
    end
  end

  it "can find the top work using get_top_work" do
    top_work = Work.get_top_work
    top_work.must_equal nil
    Vote.create(user_id: user.id, work_id: album.id)
    top_work = Work.get_top_work
    top_work.id.must_equal album.id
  end

end
