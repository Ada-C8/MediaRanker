class Work < ApplicationRecord
  has_many :upvotes, dependent: :destroy
end
