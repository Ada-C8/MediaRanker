class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work

  validates :user, presence: true, uniqueness: { scope: [:work_id], message: "You have already voted for this work"}
  validates :work, presence: true

  def create
    user = User.find_by(id: session[:logged_in_as_user])

    vote = Vote.new(user: user, work: params[:work])

    if vote.save
      flash[:success] = "Successfully upvoted!"
      redirect_back(fallback_location: root_path)
    # else
    #   flash.now[:error] = "You have already voted for this work"
    #   redirect_back(fallback_location: root_path)
    end
  end
end
