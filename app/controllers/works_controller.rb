class WorksController < ApplicationController
  def index
    @works = Work.all
    @movies = Work.where(category: "movie")
    @books = Work.where(category: "book")
    @albums = Work.where(category: "album")
  end

  # def works_params
  #   # params are what fields the user is allowed to set
  #   return params.require(:work).permit(:title, :category, :creator, :publication_year, :description)
  # end
end
