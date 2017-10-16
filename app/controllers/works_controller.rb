class WorksController < ApplicationController
  def index
    works = Work.all
    @works = works.sort_by {|work| -work.votes.count}
    movies = Work.where(category: "movie")
    @movies = movies.sort_by {|work| -work.votes.count}
    books = Work.where(category: "book")
    @books = books.sort_by {|work| -work.votes.count}
    albums = Work.where(category: "album")
    @albums = albums.sort_by {|work| -work.votes.count}
  end

  def new
    @work = Work.new
  end

  def create
    # work = Work.new(title: params[:work][:title], description: params[:work][:description], creator: params[:work][:creator], category: params[:work][:category], publication_year: params[:work][:publication_year])

    @work = Work.new(work_params)

    if @work.save
      flash[:status] = :success
      flash[:message] = "Successfully created work #{@work.id}"
      redirect_to works_path
    else
      flash.now[:status] = :failure
      flash.now[:message] = "Failed to create work"
      flash.now[:details] = @work.errors.messages
      render :new, status: :bad_request
    end
  end

  def show
    @work = Work.find_by(id: params[:id])
    unless @work
      head :not_found
    end
  end

  def edit
    @work = Work.find_by(id: params[:id])
    unless @work
      head :not_found
    end
  end

  def update
    # work_updates = params[:work]
    # @work = Work.find(params[:id])
    #
    # @work.title = work_updates[:title]
    # @work.creator = work_updates[:creator]
    # @work.category= work_updates[:category]
    # @work.publication_year = work_updates[:publication_year]
    # @work.description = work_updates[:description]

    @work = Work.find_by(id: params[:id])
    @work.update_attributes(work_params)

    if @work.save
      redirect_to work_path(@work)
      # return
    else
      render :edit, status: :bad_request
    end
  end

  def destroy
    @work = Work.find(params[:id])
    @work.destroy

    redirect_to works_path
  end

  private
    def work_params
      return params.require(:work).permit(:title, :creator, :category, :publication_year, :description)
    end
    def sort_by_vote_count
      return Work.all.sort_by{ |work| -work.votes.count}
    end
end
