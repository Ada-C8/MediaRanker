class MainController < ApplicationController

def index
  @works = Work.all
   @albums = top_ten("album")
   @books = top_ten("book")
   @movies = top_ten("movie")
end


private
def top_ten(media_type)
  types = Work.all.where(category: media_type)
  vote_hash = {}

  types.each do |work|
    work_votes = Vote.all.where(work_id: work.id).count
    vote_hash[work.id] = work_votes
  end
  top_ten = vote_hash.sort_by { |work_id, work_votes| work_votes}.reverse[0..9]
  return top_ten
end

end
