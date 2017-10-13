class MainPageController < ApplicationController
  def index
    works = Upvote.group(:work_id).count
    top = works.max_by { |id,count| count }
    @top = Work.find(top[0])

    @top_books = vote_sorter("book")
    @top_movies = vote_sorter("movie")
    @top_albums = vote_sorter("album")
  end

  private
  def vote_sorter(category)
    works = Work.where(category: category)
    work_results = works.sort_by { |work| -1*work.upvotes.count }
    top_works = work_results[0..[9, work_results.length].min]
    return top_works
  end
end
