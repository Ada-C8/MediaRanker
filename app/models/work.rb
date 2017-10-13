class Work < ApplicationRecord
  has_many :votes

  validates :title, presence: true
  validates :category, presence: true
  validates :title, uniqueness: {scope: :category}
  # this could be used to make sure a COMBINATION of fields is unique.


  def self.top_ten(cat)
    cat_list = Work.where(category: cat)
    cat_list = cat_list.sort_by {|work| work.votes.count * -1}
    return cat_list.first(10)
  end

  def self.top
    top = Work.all.sort_by {|work| work.votes.count * -1}
    return top.first
  end

  def self.sort
    Work.all.sort_by {|work| work.votes.count * -1}
  end

  def get_description
    if @description == "nil"
      @description = "a #{@category}!"
    end
  end

end
