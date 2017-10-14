class WorksController < ApplicationController
  def index
    @works = Work.all
  end

  def show
    @work = Work.find_by(id: params[:id])

    unless @work
      head :not_found
    end
  end

  def new
    @work = Work.new
  end

  def create # Add strong params
    @work = Work.new(works_params)

    if @work.save
      flash[:status] = :success
      flash[:message] = "Successfully created #{@work.category @work.id}"
      redirect_to works_path
    else
      flash[:status] = :failure
      flash[:message] = "A problem occured: Could not create #{@work.category}"
      flash[:details] = @work.errors.messages
      render :new, status: :bad_request
    end
  end

  def edit
    @work = Work.find(params[:id])
  end

  def update
    @work = Work.find_by(id: params[:id])

    unless @work
      head :not_found
      return
    end

    work_updates = params[:work]
    # This is the same as the create method params
    @work.category = work_updates[:category]
    @work.title = work_updates[:title]
    @work.creator = work_updates[:creator]
    @work.publication_year = work_updates[:publication_year]
    @work.description = work_updates[:description]

    if @work.save!
      redirect_to work_path(@work)
    else
      render :edit, status: :bad_request
    end
  end

  def destroy
    @work = Work.find_by(id: params[:id])

    unless @work
      head :not_found
      return
    end

    @work.destroy

    redirect_to works_path
  end

  private

  def works_params
    params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
end
