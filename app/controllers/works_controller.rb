class WorksController < ApplicationController
  def index
    @works = Work.all
    @movies = Work.where(category: "movie")
    @books = Work.where(category: "book")
    @albums = Work.where(category: "album")
  end

  def new
    @work = Work.new
  end

  def create
    work = Work.new(title: params[:work][:title], description: params[:work][:description], creator: params[:work][:creator], category: params[:work][:category], publication_year: params[:work][:publication_year])

    work.save
    redirect_to('/works')
  end

  def show
    @work = Work.find(params[:id])
  end

  def edit
    @work = Work.find(params[:id])
  end

  def update
    work_updates = params[:work]
    @work = Work.find(params[:id])

    @work.title = work_updates[:title]
    @work.creator = work_updates[:creator]
    @work.category= work_updates[:category]
    @work.publication_year = work_updates[:publication_year]
    @work.description = work_updates[:description]

    @work.save

    redirect_to work_path(@work)
  end

  def destroy
    @work = Work.find(params[:id])
    @work.destroy

    redirect_to works_path
  end
end
