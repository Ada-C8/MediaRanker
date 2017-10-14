class UsersController < ApplicationController


  def index
    if params[:work_id]
      @user = User.find_by(id: params[:id])
      unless @user
        head :not_found
      end
      return @user
    end
    @users = User.all
    return @users
  end

  def show
    @user = User.find_by(id: params[:id])
    unless @user
      head :not_found
    end
  end

  def login
    @user = User.find_by(user_params)
    if @user
      session[:logged_in_user] = @user.id
      flash[:status] = :success
      flash[:message] = "Succesfully logged in as existing user #{@user.name}"
      redirect_to root_path
      return
    end

    @user = User.new(user_params)
    if @user.save
      session[:logged_in_user] = @user.id
      flash[:status] = :success
      flash[:message] = "Successfully created new user #{@user.name} with ID #{@user.id}"
      redirect_to root_path
    else
      flash.now[:status] = :failure
      flash.now[:message] = "Username can't be blank"
      render :login_form, status: :bad_request
    end
  end

  def logout
    session[:logged_in_user] = nil
    flash[:status] = :success
    flash[:message] = "Successfully logged out"
    redirect_back(fallback_location: root_path)
  end


  #do not need these?
  # def create
  # end
  # def update
  # end
  # def destroy
  # end
  # def edit
  # end

  private
  def user_params
    return params.require(:user).permit(:name)
  end


  # def find_user_by_params_id
  #   @user= User.find_by(id: params[:id])
  #   unless @user
  #     head :not_found
  #   end
  # end



end
