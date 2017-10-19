require 'date'

class WorksController < ApplicationController
  def index
    @albums = Work.all.select('works.id, works.title, works.creator,
                              works.published,  votes.count(*) as vote_count')
                              .joins("LEFT JOIN Votes on Votes.work_id")
                              .where("Works.category = 'album'")
                              .group('works.id')
                              .order('vote_count DESC')

    @books = Work.all.select('works.id, works.title, works.creator,
                              works.published,  count(*) as vote_count')
                              .joins("LEFT JOIN Votes on Votes.work_id")
                              .where("Works.category = 'book'")
                              .group('works.id')
                              .order('vote_count DESC')

    @movies = Work.all.select('works.id, works.title, works.creator,
                              works.published,  count(*) as vote_count')
                              .joins("LEFT JOIN Votes on Votes.work_id")
                              .where("Works.category = 'movie'").
                              group('works.id')
                              .order('vote_count DESC')

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

      @work = Work.new(work_params)
      if @work.save
        flash[:success] = "Successfully created #{@work.category} #{@work.id}"
        redirect_to work_path(@work.id)
      else
        flash[:failure] = 'Could not create work'
        flash.now[:details] = @work.errors.messages
        render :new
      end
  end

  def upvote
    @work = Work.find(params[:id])
    @user_id = session[:user_id]
    if session[:user_id] == nil
      flash[:failure] = 'You must log in to do that'
    else
      @check = Vote.where(user_id: session[:user_id], work_id: @work.id)
      if @check[0] == nil
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

  private

  def work_params
    params.require(:title).permit(:category, :description, :creator, :published)
  end
end
