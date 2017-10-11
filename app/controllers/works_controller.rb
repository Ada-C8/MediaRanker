class WorksController < ApplicationController
  def home
    @homepage = true
  end

  def index
    @works = Work.all
  end

  def show
    @work = Work.find_by(id: params[:id])
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(category: params[:work][:category], title: params[:work][:title], creator: params[:work][:creator], publication_year: params[:work][:publication_year], description: params[:work][:description])
    if @work.save
      flash[:success] = "Your work has been added!"
      redirect_to work_path(@work.id)
    else
      flash.now[:error] = "There was a problem adding your work :("
      render :new
    end
  end

  def edit
    @work = Work.find_by(id: params[:id])
    unless @work
      redirect_to works_path
    end
  end

  def update
    @work = Work.find_by(id: params[:id])
    result = @work.update({category: params[:work][:category], title: params[:work][:title], creator: params[:work][:creator], publication_year: params[:work][:publication_year], description: params[:work][:description]})
      if result
        redirect_to work_path(@work.id)
      else
        render :edit
      end
  end

  def destroy
    work = Work.find_by(id: params[:id])

    if work.destroy
      redirect_to works_path
    else

    end
  end
end
