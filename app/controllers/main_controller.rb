class MainController < ApplicationController

  def index
    @work_top = Work.top_work

    @top = Work::CATEGORIES.map { |category| [category, Work.top_ten(category.downcase.to_sym)] }.to_h

  end
end
