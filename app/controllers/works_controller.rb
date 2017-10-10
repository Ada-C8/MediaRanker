class WorksController < ApplicationController
  def index
    @works = Work.all
  end

  def show
    @work = Work.find(params[:id])
  end

  def new
    @work = Work.new
  end

  def create # Add strong params
    work = Work.new(
      id: params[:work][:id],
      category: params[:work][:category],
      title: params[:work][:title],
      creator: params[:work][:creator],
      description: params[:work][:description],
      year: params[:work][:year]
    )
    work.save # Add redirect_to
  end

  def edit
    @work = Work.find(params[:id])
  end

  def update
    @work = Work.find(params[:id])
    work_updates = params[:work]
    @work.category = work_updates[:category]
    @work.title = work_updates[:title]
    @work.creator = work_updates[:creator]
    @work.descripton = work_updates[:descripton]
    @work.save
    # Add a redirect_to
  end

  def destroy
    @work = Work.find(params[:id])
    @work.destroy
    # Add a redirect_to
  end
end
