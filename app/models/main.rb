class Main < ApplicationRecord

#I thought this would go here...but I guess not?
  # def top_ten(media_type)
  #   types = Work.all.where(category: media_type)
  #   vote_hash = {}
  #
  #   types.each do |work|
  #     work_votes = Vote.all.where(work_id: work.id).count
  #     vote_hash[work.id] = work_votes
  #   end
  #   top_ten = vote_hash.sort_by { |work_id, work_votes| work_votes}.reverse[0..9]
  #   return top_ten
  # end

end
