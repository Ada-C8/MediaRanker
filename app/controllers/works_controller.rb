class WorksController < ApplicationController
  def index
    @works = Work.all
  end

  def show
    find_work_by_params_id
  end

  def edit
    find_work_by_params_id
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)
    if @work.save
      flash[:status] = :success
      flash[:message] = "Successfuly created new #{@work.category}"
      redirect_to work_path(@work.id)
    else
      flash.now[:status] = :failure
      flash.now[:message] = "Failed to create new work"
      flash.now[:details] = @work.errors.messages
      render :new, status: :bad_request
    end
  end

  def update
    @work = Work.find(params[:id])
    @work.update_attributes(work_params)
    if @work.save
      redirect_to work_path(@work.id)
    else
      render :edit, status: :bad_request
    end
  end

  def destroy

    current_user = nil
    if session[:logged_in_user]
      current_user = User.find_by(session[:logged_in_user])
      ## The following code is redundant
    # else
    #   flash[:status] = :failure
    #   flash[:message] = "You must be logged in to do that!"
    #   redirect_to works_path
    #   # redirect will not return need to explicitly return
    #   return
    end

    #could use for create update etc.
    if find_work_by_params_id
      if current_user != @work.user
        flash[:status] = :failure
        flash[:message] = "You must be logged in to do that!"
        redirect_to works_path
        # redirect will not return need to explicitly return
        return
      end
    end
    @work = Work.find(params[:id])
    @work.destroy
    flash[:status] = :success
    flash[:message] = "Deleted #{@work.category} #{@work.title}"
    redirect_to works_path
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
