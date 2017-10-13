class WorksController < ApplicationController
  def home
    media_hash = Work.works_by_type_hash
    @media = Work.top_ten(media_hash)
    @spotlight = Work.spotlight
  end

  def index
    @media = Work.works_by_type_hash
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
    @work = Work.find_by(id: params[:id])
    render_404 unless @work
  end

  def update
    @work = Work.find_by(id: params[:id])

    unless @work
      render_404 unless @work
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
    @work = Work.find_by(id: params[:id])
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

end
