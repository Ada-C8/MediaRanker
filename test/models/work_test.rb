require "test_helper"

describe Work do
  let(:dune) { works(:dune) }

  describe "validations" do
    it "must have a title" do
      dune.title = nil
      dune.valid?.must_equal false

      dune.title = "Dune"
      dune.valid?.must_equal true
    end

    it "must have a creator" do
      dune.creator = nil
      dune.valid?.must_equal false

      dune.creator = "Frank Herbert"
      dune.valid?.must_equal true
    end

    it "doesn't require a publication year" do
      dune.publication_year = nil
      dune.valid?.must_equal true

      dune.publication_year = 1974
      dune.valid?.must_equal true
    end

    it "doesn't require a description" do
      dune.description = nil
      dune.valid?.must_equal true

      dune.description = "happy happy"
      dune.valid?.must_equal true
    end

    describe "validating publication_year" do
      it "can't have a publication year later than this year" do
        dune.publication_year = 2020
        dune.valid?.must_equal false

        dune.publication_year = 1974
        dune.valid?.must_equal true
      end

      it "must have a numerical publication year" do
        dune.publication_year = "apple"
        dune.valid?.must_equal false

        dune.publication_year = 1974
        dune.valid?.must_equal true
      end
    end

    describe "validating uniqueness of medium-specific work" do
      it "can't have a work with the same author and title in the same medium" do
        new_work = Work.new(title: dune.title, creator: dune.creator, publication_year: 2000, category_id: dune.category_id, description: "duplicate work")

        new_work.valid?.must_equal false
        new_work.category_id = Category.find_by(name: "album").id
        new_work.valid?.must_equal true
      end
    end

  end

  describe "relations" do
    let(:cat) { Category.find_by(name: "album") }
    let(:new_work) { Work.new(creator: "Anon", title: "New Work") }

    it "can set the category through 'category'" do
      new_work.category = cat
      new_work.category_id.must_equal cat.id
    end

    it "can set the category through 'category_id'" do
      new_work.category_id = cat.id
      new_work.category.must_equal cat
    end

    it "must cascade delete associated votes" do
      dune_vote = votes(:two)
      num_votes = Vote.count

      works(:dune).destroy
      Vote.count.must_equal (num_votes - 1)
      Vote.all.wont_include dune_vote
    end
  end

  describe "#works_by_type" do
    let(:book_list) { [works(:hp), works(:dune)] }

    it "must return a collection of Works" do
      books = Work.works_by_type("book")

      books.each do |book|
        book.must_be_instance_of Work
      end
    end

    it "must return a collection of Works in the specified category" do
      books = Work.works_by_type("book")
      books.must_equal book_list

      movie = [works(:lego)]
      Work.works_by_type("movie").must_equal movie
    end
  end

  describe "#works_by_type_hash" do
    let(:works_hash) { { "books" => [works(:hp), works(:dune)],
                        "movies" => [works(:lego)],
                        "albums" => [works(:nonsense)] } }

    it "must return a hash with category name as key and array of Works as value" do
      Work.works_by_type_hash.must_equal works_hash
    end

    it "must return a hash with Works sorted by votes in descending order" do
      works_hash.each_key do |cat|
        work_list = works_hash[cat]

        (work_list.length - 1).times do |idx|
          work_list[idx].votes.length.must_be :>=, work_list[idx + 1].votes.length
        end
      end

      # add votes
      Vote.create!(user_id: users(:ron).id, work_id: works(:dune).id)
      Vote.create!(user_id: users(:harry).id, work_id: works(:dune).id)

      # resort books by num_votes DESC
      works_hash["books"] = [Work.find_by(title: "Dune"), Work.find_by(title: "Harry Potter")]

      Work.works_by_type_hash.must_equal works_hash
    end

    it "must return a hash with values as empty arrays if no works" do
      Work.destroy_all
      expected_hash = { "books" => [], "movies" => [], "albums" => [] }

      Work.works_by_type_hash.must_equal expected_hash
    end

    it "must return a hash with the works if no votes" do
      Vote.destroy_all
      new_hash = Work.works_by_type_hash

      new_hash["books"].must_include (works(:hp) && works(:dune))
      new_hash["movies"].must_equal [works(:lego)]
      new_hash["albums"].must_equal [works(:nonsense)]
    end
  end

  describe "#spotlight" do
    it "must return work with most votes" do
      Work.spotlight.must_equal works(:hp)

      # add votes
      Vote.create!(user_id: users(:ron).id, work_id: works(:lego).id)
      Vote.create!(user_id: users(:hermione).id, work_id: works(:lego).id)
      Vote.create!(user_id: users(:harry).id, work_id: works(:lego).id)

      Work.spotlight.must_equal works(:lego)
    end
  end

  describe "#num_votes_to_s" do
    let(:one_vote_work) { works(:dune) }
    let(:two_votes_work) { works(:hp) }

    it "must return a String" do
      one_vote_work.num_votes_to_s.must_be_instance_of String
    end

    it "must return 1 vote if num_votes is singular" do
      one_vote_work.num_votes_to_s.must_equal "1 vote"
    end

    it "must return num_votes votes if num_votes is 0 or > 1" do
      num_votes = two_votes_work.votes.length
      two_votes_work.num_votes_to_s.must_equal "#{num_votes} votes"
    end

    it "must take num_votes as parameter if supplied" do
      one_vote_work.num_votes_to_s(1).must_equal "1 vote"
      two_votes_work.num_votes_to_s(2).must_equal "2 votes"
    end
  end

  describe "#caption" do
    let(:with_description) { works(:lego) } # no votes, has description
    let(:no_description) { works(:nonsense) } # no votes

    it "must return a String" do
      with_description.caption.must_be_instance_of String
    end

    it "must only display num votes if no description" do
      expected = no_description.num_votes_to_s
      no_description.caption.must_equal expected

      expected = with_description.num_votes_to_s
      with_description.caption.must_equal "#{expected} - #{with_description.description}"
    end

    it "must take num_votes as optional parameter" do
      expected = no_description.num_votes_to_s
      no_description.caption(0).must_equal expected
    end
  end

end
