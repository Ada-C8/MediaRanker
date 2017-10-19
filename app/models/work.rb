class Work < ApplicationRecord
  has_many :votes, dependent: :destroy 

  validates :creator, :title, :published, :category,
            :description, presence: true

  def self.top_10(category)
    result = []
    @top_works =  Vote.limit(10).where("category= '#{category}'").group(:work_id).count
    @top_works.keys.each do |work|
      result << Work.find(work)
    end
    return result
  end

  def self.votes_for_work(work)
    return Vote.where(work_id: work.id).count
  end

  def self.find_user(id)
    return User.find(id.to_i).name
  end



  def self.user_cast_votes(user)
    return Vote.where(user_id: user.id)
  end

  def self.get_title(id)
    return Work.find(id).title
  end

  def self.get_published(id)
    return Work.find(id).published
  end

  def self.get_creator(id)
    return Work.find(id).creator
  end
end
