class Vote < ApplicationRecord
  belongs_to :users
  belongs_to :works

  # validate uniqueness, validate that user exists/hasn't voted before
end
