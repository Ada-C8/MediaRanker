class HomeController < ApplicationController
  def index
    @top_work_id = Vote.limit(1).group(:work_id).count
    @top_work = Work.find(@top_work_id.keys[0])
    @top_work_votes = Vote.where(work_id: @top_work_id.keys[0])
  end
end
