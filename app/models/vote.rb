class Vote < ApplicationRecord
  belongs_to :work, counter_cache: :vote_count #https://stackoverflow.com/questions/16996618/rails-order-by-results-count-of-has-many-association
  belongs_to :user
end
