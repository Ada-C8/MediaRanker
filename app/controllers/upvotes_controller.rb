class UpvotesController < ApplicationController
  def create
    @upvote = Upvote.new(shop_id:1,work_id:1)
    if @upvote.save
      redirect_to works_path
    end
  end
end
