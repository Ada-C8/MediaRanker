class User < ApplicationRecord
  has_many :votes, dependent: :destroy

  validates :username, uniqueness: true, presence: true

  def self.all_users_with_vote_count
    return User.left_outer_joins(:votes).distinct.select('users.*, COUNT(votes.*) AS votes_count').group('users.id').order('votes_count desc')
  end
end
