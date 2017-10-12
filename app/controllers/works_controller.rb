class WorksController < ApplicationController
  def index
    @works = Work.all
    @types = []

    @works.each do |work|
      if @types.include?(work.category)
        next
      else
        @types.push(work.category)
      end
    end 
  end

  def show
    @work = Work.find(params[:id].to_i)
  end

  def create
  end

  def new
  end

  def destroy
  end

  def edit
  end

  def update
  end
end
