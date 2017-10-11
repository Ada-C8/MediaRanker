class Work < ApplicationRecord
  has_many :votes #, dependent: :destroy


  def get_top_10_by_category

  end
  
end
