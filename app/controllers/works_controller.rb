class WorksController < ApplicationController
  def create
    @work = Work.new(title: params[:work][:title], category:params[:work][:category])
    successful = @work.save
    if successful
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    Work.find_by(id: params[:id]).destroy
    redirect_to root_path
  end

  def edit
  end

  def index
    @works = Work.all
  end

  def new
    @work = Work.new
  end

  def show
    @work = Work.find( params[:id].to_i)
  end

  def update
  end
end
