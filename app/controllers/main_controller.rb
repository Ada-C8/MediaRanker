class MainController < ApplicationController

  def index
    @work_top = Work.top_work
    # @work_ten = Work.top_ten
  end
end
