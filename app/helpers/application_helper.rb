module ApplicationHelper
  def find_user(id)
    return User.find(id).name
  end

end
