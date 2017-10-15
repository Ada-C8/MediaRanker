require "test_helper"

describe Work do
  let :work { Work.first }

  describe "validations" do
    it "can be created with all fields" do
      w = Work.new(
        category: "movie",
        title: "This is a new work",
        creator: "Not Steely Dan",
        publication_year: "1972",
        description: "An album description"
      )
      w.must_be :valid?
      w.save!

      w.errors.messages.wont_include :category
      w.errors.messages.wont_include :title
      w.errors.messages.wont_include :creator
      w.errors.messages.wont_include :publication_year
      w.errors.messages.wont_include :description
    end

    it "will raise an error if no entries are present" do
      w = Work.new
      w.save
      w.wont_be :valid?

      w.errors.messages.must_include :category
      w.errors.messages.must_include :title
      w.errors.messages.must_include :creator
      w.errors.messages.wont_include :publication_year
      w.errors.messages.wont_include :description
    end

    it "will raise an error if one of required entry is not present" do
      work[:title] = ""
      work.save

      work.wont_be :valid?
      work.errors.messages.must_include :title
      work.errors.messages.wont_include :category
      work.errors.messages.wont_include :creator
      work.errors.messages.wont_include :publication_year
      work.errors.messages.wont_include :description
    end
  end # Describe

  describe "relations" do
    it "must respond to votes" do
      before_vote_count = work.votes.count

      new_user = User.create!(name: "This is a new user to test this relation")
      new_vote = Vote.create!(user_id: new_user.id, work_id: work.id)

      work.must_respond_to :votes
      work.votes.must_include new_vote
      work.votes.count.must_equal before_vote_count + 1
    end
  end # Des

end # Des
