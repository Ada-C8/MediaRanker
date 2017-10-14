class UsersController < ApplicationController
  def index
    @users = User.order(:id)
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def login_form

  end

  def login
    input = params[:name]
    @user  = User.find_by(name: input)
    if @user
    # login_input = params[:name]
    #
    # @user = User.find_by(name: login_input)
    # user_id = params[:id]
    #
    # #if user is true mean user != nil, returns a user id
    # if @user
      session[:logged_in] = @user
      flash[:status] = :success
      flash[:message] = "Successfully logged in as existing user #{@user.name},#{@user.id}"
      redirect_to root_path
    else
      create_user_path
    end

    def create
      # @user = User.create! name: params[:name]
      @user = User.new(user_params)
      # if @user != nil

        session[:logged_in] = @user.id
        flash[:status] = :success
        flash[:message] = "Successfully created new user #{@user.name} with ID #{@user.id} "
        redirect_to root_path
      # end
    end
  end

  private
  def user_params
    return params.require(:user).permit(:id, :name, :created_at)
  end
end
