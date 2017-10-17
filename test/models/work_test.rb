require "test_helper"

describe "work" do
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

  describe "top_work" do
    it "Returns right work from data base" do
      best_work = Work.where(category: "album").top_work
      best_work.title.must_equal "Album"
    end

    it "Returns new top work after new votes" do
      u1 = User.find_by(name: "Julia")
      u2 = User.find_by(name: "Pavel")
      w = Work.find_by(title: "Book")
      Vote.create(user_id: u1.id, work_id: w.id)
      Vote.create(user_id: u2.id, work_id: w.id)
      new_best_work = Work.top_work
      new_best_work.title.must_equal "Book"
    end
  end

  describe "top" do
    it "Returns 10 works in right order" do
      users = {}

      books_count = 20

      books_count.times do |i|
        user = User.create(name: "User #{i + 1}")
        users[i] = user
      end

      works = []
      votes = []

      books_count.times do |i|
        w = Work.create(category: "book", title: "Book #{i + 1}")

        (i + 1).times do |j|
           votes << Vote.create(user_id: users[j].id, work_id: w.id)
        end

        works << w
      end

      top_ten = Work.top_ten("book")

      top_ten.length.must_equal 10
      top_ten.first.title.must_equal "Book 20"
      top_ten.last.title.must_equal "Book 11"

      votes.each do |vote|
        vote.destroy
      end

      works.each do |work|
        work.destroy
      end

      users.each do |i, user|
        user.destroy
      end
    end
  end
end
