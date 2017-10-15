class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit, :update, :destroy]

  def home
    media_hash = Work.works_by_type_hash
    @media = Work.top_ten(media_hash)
    @spotlight = Work.spotlight
  end

  def index
    @media = Work.works_by_type_hash
  end

  def show
    head :not_found unless @work
    # unless @work
    #   render_404
    # end
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)

    if @work.save
      flash[:status] = :success
      flash[:message] = "Successfully created #{@work.category.name} #{@work.id}"
      redirect_to work_path(@work.id)
    else
      # puts "error message"  DEBUGGING
      # puts @work.errors.inspect
      flash.now[:status] = :failure
      flash.now[:message] = "A problem occurred: Could not create #{@work.category.name}"
      flash.now[:details] = @work.errors.messages
      render :new, status: :bad_request
    end
  end

  def edit
    head :not_found unless @work
  end

  def update
    # what do you do if category changed to invalid selection?
    # can it be changed if using a drop-down / form?
    unless @work
      head :not_found
      return
    end

    if @work.update_attributes work_params
      flash[:status] = :success
      flash[:message] = "Successfully updated #{@work.category.name}"
      redirect_to root_path
    else
      flash.now[:status] = :failure
      flash.now[:message] = "A problem occurred: Could not update #{@work.category.name}"
      flash.now[:details] = @work.errors.messages
      render :edit, status: :bad_request
    end

  end

  def destroy
    unless @work
      head :not_found
      return
    end

    @work.destroy

    if @work.destroyed?
      flash[:status] = :success
      flash[:message] = "Successfully destroyed #{@work.category.name} #{@work.id}"
      redirect_to root_path
    else
      flash[:status] = :failure
      flash[:message] = "Unable to delete #{@work.category.name} #{@work.id}"
      flash[:details] = @work.errors.messages

      redirect_back fallback_location: root_path
    end
  end

  private

  def work_params
    return params.require(:work).permit(:title, :creator, :publication_year, :description, :category_id)
  end

  def find_work
    @work = Work.find_by(id: params[:id])
  end

end
