class User < ApplicationRecord
  has_many :votes, dependent: :destroy
  has_many :works, through: :votes

  validates :name, presence: true, uniqueness: true

  def created
    created_at.strftime('%B %d, %Y')
  end

  def recs
    works = Hash.new(0)

    votes.each do |v|
      v.work.recs.each do |t, n|
        works[t] += n
      end
    end

    works
  end

  def rec_list
    ids = recs
    ids = ids.keys.sort_by{|k| -ids[k]}

    rec_works = []

    ids.each do |id|
      work =  Work.find(id)
      rec_works << work unless works.include?work
    end

    rec_works[0...3]
  end

end
