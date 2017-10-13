class WorksController < ApplicationController
  def index
    @albums = Album.all
  end
end
