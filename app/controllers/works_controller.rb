class WorksController < ApplicationController
  def index
    @works = Work.all
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)

    if @work.save
      redirect_to works_path
    else
      render :new, status: :bad_request
    end
  end

  def edit
    find_work_by_params_id
    # @work = Work.find_by(id: params[:id])
    # unless @work
    #   head :not_found
    # end
  end

  def update
    if find_work_by_params_id
      @work.update_attributes(work_params)
      if @work.save
        redirect_to work_path(@work)
      else
        render :edit, status: :bad_request
      end
    end
    # @work = Work.find(params[:id])
    # result = @work.update(work_params)
    # if result
    #   redirect_to work_path(@work.id)
    # else
    #   render :edit
    # end
  end

  def show
    find_work_by_params_id
    # @work = Work.find_by(id: params[:id])
    # unless @work
    #   head :not_found
    # end
  end

  def destroy
    if find_work_by_params_id
      @work.destroy
      redirect_to works_path
    end
    # work = Work.find(params[:id])
    # work.destroy
    #
    # redirect_to works_path
  end

  private
    def work_params
      return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
    end

    def find_work_by_params_id
      @work = Work.find_by(id: params[:id])
      unless @work
        head :not_found
      end
      return @work
    end
end
