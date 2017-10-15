require 'pry'
class WorksController < ApplicationController
  def index
    @works = all_works_by_category
  end

  def show
  end

  def edit
  end

  def update
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new work_params
    if @work.save
      flash[:success] = "Work added successfully"
      redirect_to works_path
    else
      flash.now[:error] = "Work not added successfully"
      render :new
    end
  end

  def destroy
  end
end

private
def all_works_by_category
  works = Work.order(:title).group_by { |work| work.category }
  return works
end

def all_works_by_votes
  works = all_works_by_category
  works = works.each do |key, values|
    works[key] = (values.sort_by {|value| value.votes.length}).reverse
  end
  return works
end

def work_params
  return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
end
