class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit, :destroy, :update]

  def render_404
    render file: "#{Rails.root}/public/404.html", layout: false, status: 404
  end

  def index
    @works = Work.all
  end

  def create
    @work = Work.new work_params

    if @work.save
      flash[:success] = "Successfully created #{@work.category} #{@work.id}"
      redirect_to work_path(@work.id)
    else
      @errors = @work.errors
      flash[:failure] = "A problem occurred: Could not create #{@work.category}"
      render :new
    end
  end

  def new
    @work = Work.new
  end

  def edit
    redirect_to root_path unless @work
  end

  def show
    render_404 unless @work
    # @votes = @work.votes.order(:created_at)
  end

  def update
    redirect_to root_path unless @work

    if @work.update_attributes work_params
      flash[:success] = "Successfully updated #{@work.category} #{@work.id}"
      redirect_to work_path(@work.id)
    else
      render :edit
    end
  end

  def destroy
    @work.destroy

    flash[:success] = "Successfully destroyed #{@work.category} #{@work.id}"
    redirect_to root_path
  end

  def main
    @works= Work.all
    #find collection of top works in each category here or in model
  end

  private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end

  def find_work
      @work = Work.find_by(id: params[:id])
  end

end
