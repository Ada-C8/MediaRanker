class MainPageController < ApplicationController
  def index
    @works = Work.order(:title).group_by { |work| work.category }
  end
end
