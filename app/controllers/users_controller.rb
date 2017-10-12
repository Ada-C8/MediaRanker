class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(
    user_params
    )
    if @user.save
      redirect_to user_path
    else
      render :new
    end
  end

  def login_form
  end

  def login
    name = params[:user][:name]
    user = User.find_by(name: name)
    if user
      session[:logged_in_user] = user.id
      redirect_to works_path
    else
      flash[:status] = :failure
      flash[:message] = "User not created "
      render :login_form
    end
  end

  # def get_votes
  #   vote_works = []
  #   # vote1 = self.votes
  #   self.votes.each do |vote|
  #     vote_works << WorksController.find_work(vote.work_id)
  #   end
  #   return vote_works
  # end
  
  #create a class vote_info
  # for each vote, get the work and create a new instance of vote_info, fill in details (title and published etc,) and push it into an array
  # return that array

  # def edit
  #   @user = User.find(params[:id])
  # end
  #
  # def update
  #   @user = User.find(params[:id])
  #   result = @user.update(user_params)
  #
  #   if result
  #     redirect_to user_path(@user.id)
  #   else
  #     render :edit
  #   end
  # end
  #
  # def destroy
  #   @user = User.find(params[:id])
  #   if @user.destroy
  #     redirect_to users_path
  #   else
  #     #error message
  #   end
  # end

  private

  def user_params
    return params.require(:user).permit(:name)
  end

end
