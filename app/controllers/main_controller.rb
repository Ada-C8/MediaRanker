class MainController < ApplicationController

  def index
    @books = MediaInstance.ten_by_type("book")
    @movies = MediaInstance.ten_by_type("movie")
    @music = MediaInstance.ten_by_type("music")
    @feature = MediaInstance.all.sample
  end

end
