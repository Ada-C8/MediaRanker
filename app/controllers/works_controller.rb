class WorksController < ApplicationController
  def index
    @albums = Album.all

    @books = Book.all

    @movies = Movie.all
  end

  def show
  

  end

  def new
    #if params[:category] == 'book'

  end

  def create
     task = Task.new(title: params[:task][:title], description: params[:task][:description], due_date: params[:task][:due_date], complete: false)
    task.save
    redirect_to tasks_path
  end
end
