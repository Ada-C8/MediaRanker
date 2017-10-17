class WorksController < ApplicationController
  def index
    @albums = Work.where(category: "album")
    @books = Work.where(category: "book")
    @movies = Work.where(category: "movie")
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)
    if @work.save
      flash[:status] = :success
      flash[:message] = "Successfully created #{@work.category}: #{@work.title}"
      redirect_to works_path
    else
      # Tell the user what went wrong
      flash.now[:status] = :failure
      flash.now[:message] = "Failed to create work"
      flash.now[:details] = @work.errors.messages
      render :new, status: :bad_request
    end
  end
  # @work = Work.create(title: params[:work][:title], category: params[:work][:category], creator: params[:work][:creator], year: params[:work][:year], description: params[:work][:description])


  def show
    find_work_by_params_id
    # unless  @work
    #   flash[:status] = :not_found
    #   flash[:message] = "Work not found"
    #   # head :not_found
    # end
  end

  def edit
    find_work_by_params_id
  end

  def update
    if find_work_by_params_id
      @work.update_attributes(work_params)
      if @work.save
        redirect_to work_path(@work)
        return
      else
        render :edit, status: :bad_request
        return
      end
    end
  end


  private
  def work_params
    return params.require(:work).permit(:title, :category, :creator, :year, :description)
  end

  def find_work_by_params_id
  @work = Work.find_by(id: params[:id])
  unless @work
    head :not_found
  end
  return @work
end

end
