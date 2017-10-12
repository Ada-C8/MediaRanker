class AlbumController < ApplicationController
  def index
    @albums = Album.all
  end
end
