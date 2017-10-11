class HomepageController < ApplicationController
  def index
    @top_work = Work.get_top_work
    @top_works = Work.get_top_works(Work.get_categories)
    if @top_work
      @plural = @top_work.votes.count == 1 ? "" : "s"
    end
  end
end
