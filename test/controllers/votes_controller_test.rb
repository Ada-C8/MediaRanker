require "test_helper"

describe VotesController do

  describe "#create" do
    it "returns as found if a vote is created" do
      before_vote_count = Vote.count
      # Create a work and make sure it is valid
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
        User.first.must_be :valid?

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

    it "returns as a redirect to the works_path if the vote could not be created" do
      before_count = Vote.count

      # Use an existing user
      user_id = users(:one).id

      # User an existing work
      work_id = works(:album).id

      vote_data = {
        vote: {
        user_id: user_id,
        work_id: work_id
        }
      }

      post votes_path, params: vote_data

      must_respond_with :redirect
      must_redirect_to work_path(vote_data[:vote][:work_id])
      Vote.count.must_equal before_count
    end

  end # Des
end # Des
