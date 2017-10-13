class Vote < ApplicationRecord
  belongs_to :User
  belongs_to :work

  def media_spotlight
    # if there is a tie, the first key is used(the oldest record or lowest id)

    # returns should return a hash that has work_id as a key and associated count as the value.
    hash = Vote.group(:work_id).count

   # using max_by to find the key value pair to find the max value
    media_max = hash.max_by{ |k,v| v}

    # media max is an array. index 0 is the key(id) index 1 is the value(amount of votes)
    return Work.find(media_max[0])
  end
end
