class WorksController < ApplicationController
  before_action :find_work

  def home
    @top_work = Work.order_by_popularity(Work.all).first
    @albums = Work.order_by_popularity(Work.albums).first(10)
    @books = Work.order_by_popularity(Work.books).first(10)
    @movies = Work.order_by_popularity(Work.movies).first(10)
  end

  def index
    @albums = Work.albums
    @books = Work.books
    @movies = Work.movies
  end

  def show
    # @work = Work.find_by(id: params[:id].to_i )

    unless @work
      render_404
    end
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new

    @work = Work.create work_params
    if @work.id != nil
      flash[:success] = "Successfully created #{@work.category} #{@work.id}"
      redirect_to works_path
    else
      flash[:failure] = "A problem occurred. Coult not create work"

      if @work.errors.any?
        flash.now[:errors] = @work.errors
      end

      render :new
    end
  end

  def edit
    # @work = Work.find_by(id: params[:id])
  end

  def update
    # @work = Work.find_by(id: params[:id])

    unless @work
      flash[:error] = "Work with id #{params[:id]} not found"
      redirect_to works_path
    end

    if @work.update_attributes work_params
      flash[:success] = "Successfully updated #{@work.category} #{@work.id}"
      redirect_to works_path
    else
      flash[:failure] = "Work #{@work.id} unable to update"
      render :edit
    end
  end

  def destroy
    # Work.find_by(id: params[:id]).destroy
    @work.destroy

    redirect_to works_path
  end

private
  def find_work
    @work = Work.find_by(id: params[:id].to_i )
  end

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
end
