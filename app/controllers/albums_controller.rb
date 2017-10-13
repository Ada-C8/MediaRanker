class AlbumsController < ApplicationController
  def show
    @album = Album.find(params[:id])
    @votes = Vote.where(work_id: @album.id)
  end

  def edit
    @album = Album.find(params[:id])
  end
end
