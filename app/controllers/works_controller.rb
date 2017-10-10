class WorksController < ApplicationController
  def index
    @works = Work.all
  end

  def new
    @work = Work.new
  end

  def create
    work = Work.new(title: params[:work][:title], description: params[:work][:description], creator: params[:work][:creator], category: params[:work][:category], publication_year: params[:work][:publication_year])

    work.save
    redirect_to('/works')
  end
end
