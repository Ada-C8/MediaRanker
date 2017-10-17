require "test_helper"

describe VotesController do
  # describe "create" do
  #   it "Returns success when user is voting for the first time" do
  #     vote_data = {
  #       vote: {
  #         vote_user_id: User.last.id,
  #         vote_work_id: Work.first.id
  #       }
  #     }
  #     Vote.new(user_id: vote_data[:vote][:vote_user_id], work_id: vote_data[:vote][:vote_work_id]).must_be :valid?
  #
  #     post votes_path, params: vote_data
  #
  #     must_respond_with :redirect
  #     must_redirect_to works_path
  #   end
  #
  #   it "Don't let to vote for same work for the second time" do
  #     vote_data = {
  #       vote: {
  #         vote_user_id: User.first.id,
  #         vote_work_id: Work.first.id,
  #       }
  #     }
  #     post votes_path, params: vote_data
  #     start_count = Vote.count
  #
  #     post votes_path, params: vote_data
  #
  #     Vote.count.must_equal start_count
  #     must_respond_with :redirect
  #     must_redirect_to works_path
  #   end
  #
  # end
end
