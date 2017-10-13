class Vote < ApplicationRecord
  has_one :user
  has_one :work

  #validates uniquness of user_id and work_id 
end
