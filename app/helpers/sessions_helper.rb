module SessionsHelper

  def votes_for_users(user)
    return Vote.where(user_id: user.id).count
  end

  def user_signed_in
    return session[:user_id] != nil
  end

  def get_user_name
    return User.find(session[:user_id]).name
  end

  def get_user_id
    return session[:user_id]
  end
end
