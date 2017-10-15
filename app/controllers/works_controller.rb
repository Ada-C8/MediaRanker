class WorksController < ApplicationController

  def index
    @works = Work.all
  end

  def show
    find_work_by_params_id
  end


  def new
    @work = Work.new
  end


  def edit
    find_work_by_params_id
  end

  def create
    strong_params = work_params
    @work = Work.new(strong_params)
    if @work.save
      flash[:status] = :success #successs here is an english word
      flash[:message] = "Successfully created #{@work.category}"
      redirect_to works_path
    else
      flash.now[:status] = :failure
      flash.now[:message] = "Failed to create #{@work.category}"
      flash.now[:details] = @work.errors.messages
      render :new, status: :bad_request
    end
  end

  def update
    strong_params = work_params
    find_work_by_params_id
    unless @status == true
      @work.update_attributes(strong_params)
      if @work.save
        flash[:status] = :success #successs here is an english word
        flash[:message] = "Successfully edited #{@work.category}"
        redirect_to work_path(params[:id])
        return
      else
        flash.now[:status] = :failure
        flash.now[:message] = "Failed to create #{@work.category}"
        flash.now[:details] = @work.errors.messages
        render :edit, status: :bad_request
        return
      end
    end
  end

  def destroy
    find_work_by_params_id
    unless @status == true
      work = Work.find(params[:id])
      work.destroy
      redirect_to works_path
    end
  end

private
  def work_params
    return params.require(:work).permit(:title, :category, :creator, :pub_year, :description)
  end

  def find_work_by_params_id
    @work = Work.find_by(id: params[:id])
    unless @work
      head :not_found
      @status = true
    end
  end
end
