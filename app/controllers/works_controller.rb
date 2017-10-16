require 'date'

class WorksController < ApplicationController
  def index
    @albums = Work.where(category: 'album')
    @books = Work.where(category: 'book')
    @movies = Work.where(category: 'movie')
  end

  def destroy
    @work = Work.find(params[:id])
    @votes = Vote.where(work_id: @work.id)

    @votes.each do |vote|
      vote.destory
    end

    @work.destroy
    flash[:deleted] = "Successfully destoryed #{@work.category} #{@work.id}"
    redirect_to root_path
  end

  def show

    @work = Work.find(params[:id])
    @votes = Vote.where(work_id: @work.id)
  end

  def new
    @work = Work.new
  end

  def create
    if params[:work][:title] == ""
      flash[:failed] = "title can't be blank"
      redirect_to new_work_path
    else

      @work = Work.new(title: params[:work][:title],
                      description: params[:work][:description],
                      category: params[:work][:category],
                      creator: params[:work][:creator],
                      published: params[:work][:published])
      @work.save

      flash[:success] = "Successfully created #{@work.category} #{@work.id}"
      redirect_to work_path(@work.id)
    end
  end

  def upvote
    @work = Work.find(params[:id])
    @user_id = session[:user_id]
    if session[:user_id] == nil
      flash[:failure] = 'You must log in to do that'
    else
      @check = Vote.where(user_id: session[:user_id], work_id: @work.id)
      if @check == nil
        @vote = Vote.new(category: @work.category,
                        work_id: @work.id,
                        date: Date.today,
                        user_id: session[:user_id])
        @vote.save

      else
        flash[:notice] = "You have already voted for this work"

      end

    end

    redirect_to work_path

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
end
