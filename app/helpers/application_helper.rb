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
end
