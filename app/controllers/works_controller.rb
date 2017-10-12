class WorksController < ApplicationController

  def home
    @works = Work.order(:category)
    @winner = @works.max_by {|work| work.votes.length}
    # @sorted_movies = @works.top_ten("movie")

  end

  def index
    @works = Work.order(:category)
  end

  def show
    @work = Work.find_by(id: params[:id])
    unless @work
      render_404
    end
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.create work_params
    if @work.id != nil
      flash[:sucess] = "Work added successfully"
      redirect_to works_path
    else
      flash.now[:error] = "A problem occured: could not create #{@work.category}"
      render :new
    end
  end

  def edit
    @work = Work.find_by(id: params[:id])
    unless @work
      redirect_to works_path
    end
  end

  def update
    @work = Work.find_by(id: params[:id])
    result = @work.update( work_params )
    if result
      flash.now[:success] = "Successfully updated #{@work.category} #{@work.id}"
      redirect_to work_path(@work.id)
    else
      flash.now[:error] = "Work not editted successfully"
      render :edit
    end
  end

  def destroy
    @work = Work.find_by(id: params[:id])
    if @work.destroy
      flash[:success] = "Successfully destroyed #{@work.category} #{@work.id}"
      redirect_to works_path
    else

    end
  end

  private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end

end
