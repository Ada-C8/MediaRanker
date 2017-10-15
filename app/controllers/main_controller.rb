class MainController < ApplicationController

  def index
    @books = MediaInstance.ten_books
    @movies = MediaInstance.ten_movie
    @music = MediaInstance.ten_music
    @feature = MediaInstance.all.sample
  end

end
