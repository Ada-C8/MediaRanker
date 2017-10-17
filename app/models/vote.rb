class Vote < ApplicationRecord
  belongs_to :user, required: false
  belongs_to :work, required: false
end
