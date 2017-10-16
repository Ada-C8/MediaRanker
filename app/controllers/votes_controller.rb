class VotesController < ApplicationController
  def create
    vote = Vote.new
    if session[:user_id] && !already_voted
      vote.user_id = params[:user_id]
      vote.work_id = params[:work_id]
      if vote.save
        flash[:success] = "Vote submitted"
      else
        flash[:error] = "Vote failed to save"
      end
    elsif session[:user_id] && already_voted
      flash[:error] = "You have already up-voted this work"
    else
      flash[:error] = "You must be logged in to vote"
    end
    redirect_back(fallback_location: root_path)
  end

  private

  def already_voted
    user = User.find_by(id: session[:user_id])
    user.votes.any? { |vote| vote.work_id == params[:id] }
  end
end

# 2.4.0 :002 > Vote.create(work_id: 22, user_id: 1)
#    (0.2ms)  BEGIN
#   Work Load (0.3ms)  SELECT  "works".* FROM "works" WHERE "works"."id" = $1 LIMIT $2  [["id", 22], ["LIMIT", 1]]
#   User Load (0.3ms)  SELECT  "users".* FROM "users" WHERE "users"."id" = $1 LIMIT $2  [["id", 1], ["LIMIT", 1]]
#   SQL (0.9ms)  INSERT INTO "votes" ("created_at", "updated_at", "user_id", "work_id") VALUES ($1, $2, $3, $4) RETURNING "id"  [["created_at", "2017-10-16 12:11:34.028369"], ["updated_at", "2017-10-16 12:11:34.028369"], ["user_id", 1], ["work_id", 22]]
#   SQL (1.0ms)  UPDATE "works" SET "votes_count" = COALESCE("votes_count", 0) + 1 WHERE "works"."id" = $1  [["id", 22]]
#    (0.8ms)  COMMIT
#  => #<Vote id: 2, created_at: "2017-10-16 12:11:34", updated_at: "2017-10-16 12:11:34", user_id: 1, work_id: 22>
