class WorksController < ApplicationController

  before_action :find_work, only: [:show, :edit, :update, :destroy]

  def index
    @works = Work.all
  end

  def show
    unless @work
      head :not_found
    end
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(works_params)

    if session[:logged_in_session] != nil
      if save_and_flash(@work)
        redirect_to works_path
      else
        render :new, status: :bad_request
      end
    else
      not_logged_in_msg
      render :new
    end
  end

  def edit; end

  def update
    unless @work
      head :not_found
      return
    end

    if session[:logged_in_session] != nil
      @work.update_attributes(works_params)

      if save_and_flash(@work)
        redirect_to work_path(@work.id)
      else
        render :edit, status: :bad_request
      end

    # This logic if the user is not logged in
    else
      not_logged_in_msg
      render :new
    end
  end

  def destroy
    unless @work
      head :not_found
      return
    end

    if session[:logged_in_session] != nil
      @work.destroy

      flash[:status] = :success
      flash[:message] = "Successfully destroyed #{@work.category} #{@work.id}"
      redirect_to works_path
    # This logic if the user is not logged in
    else
      not_logged_in_msg
      redirect_to work_path(@work)
    end
  end

  private

  def works_params
    params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end

  def find_work
    @work = Work.find_by_id(params[:id])
  end

end
