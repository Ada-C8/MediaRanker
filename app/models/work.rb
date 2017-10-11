class Work < ApplicationRecord

  def album
    if work.category == "album"
      return true
    else
      return false
    end
  end

end
