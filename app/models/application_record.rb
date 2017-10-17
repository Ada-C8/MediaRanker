class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def created_date
    created_at.strftime("%b %e, %Y")
  end
end
