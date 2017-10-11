class Vote < ApplicationRecord
  belongs_to :User
  belongs_to :work
end
