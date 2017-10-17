class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit, :update, :destroy]

  def home
    @homepage = true
  end

  def index
    @works = Work.all
  end

  def show
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(category: params[:work][:category], title: params[:work][:title], creator: params[:work][:creator], publication_year: params[:work][:publication_year], description: params[:work][:description])
    if @work.save
      flash[:success] = "Your work has been added!"
      redirect_to works_path
    else
      flash.now[:error] = "There was a problem adding your work :("
      render :new
    end
  end

  def edit
    unless @work
      redirect_to works_path
    end
  end

  def update
    result = @work.update({category: params[:work][:category], title: params[:work][:title], creator: params[:work][:creator], publication_year: params[:work][:publication_year], description: params[:work][:description]})
      if result
        redirect_to work_path(@work.id)
      else
        render :edit
      end
  end

  def destroy
    if @work.destroy
      redirect_to works_path
    end
  end

  private

  def find_work
    @work = Work.find_by(id: params[:id])
  end
end
