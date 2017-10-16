class WorksController < ApplicationController

before_action :find_work, only: [:show, :edit, :update, :destroy]

  def home
    @works = Work.order(:category)
    @winner = @works.winner
  end

  def index
    @works = Work.order(:category)
  end

  def show
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
      flash[:sucess] = "Successfully created #{@work.category} #{@work.id}"
      redirect_to work_path(@work.id)
    else
      flash.now[:error] = "A problem occured: could not create #{@work.category}"
      render :new
    end
  end

  def edit
    unless @work
      redirect_to works_path
    end
  end

  def update
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

  def find_work
    @work = Work.find_by(id: params[:id])
  end

end
