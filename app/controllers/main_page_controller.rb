class MainPageController < ApplicationController
  skip_before_action :logged_in?, only: [:index]

  def index
    # top_voted = []
    @works = all_works_by_votes
    @spotlight_work = Work.spotlight(@works)
  end
end

private

def all_works_by_category
  works = Work.order(:title).group_by { |work| work.category }
  if !(works)
    work = Work.new
    work.title = "Add some media, it would be so cool..."
    work.user_id = 1
    works = {
      "Add Some Media To Rank!" => [work]
    }
  end
  return works
end

def all_works_by_votes
  works = all_works_by_category
  works = works.each do |key, values|
    works[key] = (values.sort_by {|value| value.votes.length}).reverse
  end
  return works
end



# def spotlight
#   top_voted = []
#   all_works = all_works_by_title
#   all_works = all_works.each do |key, values|
#     all_works[key] = (values.sort_by {|value| value.votes.length}).reverse
#     top_voted << all_works[key].first
#   end
#   spotlight = top_voted.inject do |memo, work|
#     raise ArgumentError.new "Can only select spotlight from works" if !(work.is_a? Work)
#     memo.votes.length >= work.votes.length ? memo : work
#   end
#   return spotlight
# end
