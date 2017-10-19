class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work, counter_cache: true # counts each vote assoc. with a work (votes_count)
end
