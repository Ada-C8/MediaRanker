require "test_helper"

describe VotesController do
  describe "#new" do
    it "returns success if the an instance of Vote is made" do
      get new_vote_path

      must_respond_with :success
    end
  end

  describe "#create" do
    it "returns success if a vote is created" do
      before_vote_count = Vote.count
      # Create a work
        work_data = {
          work: {
            category: "book",
            title: "This is a new book being made",
            creator: "J.K. Rowling",
            publication_year: 2001,
            description: "A boy to has a scar",
          }
        }

        work = Work.new(work_data[:work])
        work.save!
        work.must_be :valid?

        # Use an existing user
        user_id = User.first.id

        vote_data = {
          vote: {
          user_id: user_id,
          work_id: work.id
          }
        }

        post votes_path, params: vote_data

        must_respond_with :redirect
        must_redirect_to work_path(vote_data[:vote][:work_id])
        Vote.count.must_equal before_vote_count + 1
    end

  end # Des
end # Des
