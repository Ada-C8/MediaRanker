module ApplicationHelper
  def find_user(id)
    return User.find(id).name
  end

  def votes_for_work(work)
    return Vote.where(work_id: work.id).count
  end

  def top_10(category)
    result = []
    @top_works =  Vote.limit(10).select('work_id, count(*) as count').where(category: category).group('work_id').order('count DESC')
    @top_works.each do |work|
      result << Work.find(work.work_id)
    end
    return result
  end

  def votes_for_users(user)
    return Vote.where(user_id: user.id).count
  end

  def user_signed_in
    return session[:user_id] != nil
  end

  def get_user_id
    return session[:user_id]
  end

  def get_user_name
    return User.find(session[:user_id]).name
  end

  def user_cast_votes(user)
    return Vote.where(user_id: user.id)
  end

  def get_title(id)
    return Work.find(id).title
  end

  def get_published(id)
    return Work.find(id).published
  end

  def get_creator(id)
    return Work.find(id).creator
  end
end
