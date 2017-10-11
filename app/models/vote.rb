class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work
  # use scope to make sure one vote per user per work 
end
