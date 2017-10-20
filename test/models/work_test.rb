require "test_helper"

describe Work do
  let :title {"test book title"}

  describe 'validations' do
    # this is the positive test:
    it 'is valid' do
      b = Work.new(title: title)
      b.must_be :valid?
    end

    # all for title: #########################
    # this is the negative test
    it 'requires a title' do
      b = Work.new
      is_valid = b.valid?
      is_valid.must_equal false
      b.errors.messages.must_include :title
    end
    it 'requires a unique title' do
      title = "test book"
      b1 = Work.create!(title: title)
      b2 = Work.new(title: title)
      b2.wont_be :valid?
    end
    # all for description: #########################
    # this is the positive test:
    it "description is acceptable length (<500)" do
      descriptions = [
        "I am less than 500 characters",
        "a" * 500,
        "a" * 10,
        "a" * 0]
        descriptions.each do |desc|
          b = Work.new(title: title, description: desc)

          b.must_be :valid?
        end
      end
      # this is the negative test:
      it "desciption will be invalid if over 500 characters" do
        description = "a" * 501
        b = Work.new(title: title, description: description)
        b.wont_be :valid?
        b.errors.messages.must_include :description
      end

    end

    describe 'relations' do
      it "can have a vote" do
        b = Work.new(title: title)
        b.must_respond_to :votes
      end
    end


    describe 'sort_by_category' do
      # need to seed album with a vote connected to it for this to work
      let :album {Work.sort_by_category("album")}

      it "sorts the categories" do
        # album1 = Work.sort_by_category("album").first
        album.first.must_be_kind_of Work

        album.first.category.must_equal "album"
      end
    end

    describe 'popular_works' do
      let :user { User.first }
      let :work { Work.first }
      let :vote { Vote.new(work: work, user: user) }

      let :work2 {Work.first + 1 }

      it "identifies the top 10" do
        Work.popular_works("album").first.title.must_equal "Harry Potter"
      end
    end

    describe "top " do

      # let :user { User.first }
      let :work { Work.first }

      # let :user1 { User.last }
      # let :work1 { Work.last }
      #
      # let :user2 { User.first + 1  }
      # Dan's feedback:
      # All of these let statements will not be executed unless the variables they create are referenced. This means that in this test, you won't have all those votes, which probably makes the test invalid.
      # Instead, you should just do this work at the top of the test block, as part of the Arrange step.
      # let :vote { Vote.new(work: work, user: user) }
      # let :vote1 { Vote.new(work: work1, user: user1) }
      # let :vote2 { Vote.new(work: work, user: user2) }

      it "finds the most voted for work" do
        10.times do |i|
          user = User.create(name: "user_#{i}")
          Vote.create!(work: work, user: user)
        end
        Work.top.title.must_equal work.title
      end
    end


  end
