class WorksController < ApplicationController
  def index
    @works = Work.all
    @albums = Work.where(category: 'album')
    @books = Work.where(category: 'book')
    @movies = Work.where(category: 'movie')
    @top_work_id = Vote.limit(1).group(:work_id).order('count_work_id DESC').count('work_id')
    @top_work = Work.find(@top_work_id.keys[0])
    @top_work_votes = Vote.where(work_id: @top_work_id.keys[0])
  end

  def destroy
    @work = Work.find(params[:id])
    @work.destroy

    redirect_to works_path
  end

  def show
    @work = Work.find(params[:id])
    @votes = Vote.where(work_id: @work.id)
  end

  def new
    #if params[:category] == 'book'

  end


  def update
    @work = Work.find(params[:id])
    @work.category = params[:work][:category]
    @work.description = params[:work][:description]
    @work.creator = params[:work][:creator]
    @work.published = params[:work][:published]
    @work.title = params[:work][:title]

    @work.save
    redirect_to work_path
  end

  def edit
    @work = Work.find(params[:id])
  end

  def show_all
    @works = Work.all
  end

  def create
     task = Work.new(title: params[:task][:title], description: params[:task][:description], due_date: params[:task][:due_date], complete: false)
    task.save
    redirect_to tasks_path
  end



end
