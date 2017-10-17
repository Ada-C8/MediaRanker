class UsersController < ApplicationController
  def index
    @users = User.order('created_at ASC')
  end

  def show
    @user = User.find_by(id: params[:id])

    head :not_found unless @user

    # render_404 unless @user
  end

  # def new
  #   @user = User.new
  # end

  # def create
  # end

  def login_form
    @user = User.new
  end

  # creates a user if doesn't already exist
  def login
    @user = User.find_by(name: params[:user][:name])

    if @user
      session[:user_id] = @user.id
      flash[:status] = :success
      flash[:message] = "Successfully logged in as existing user #{@user.name}"

      redirect_to root_path

    else
      @user = User.new(user_params)

      if @user.save
        flash[:status] = :success
        flash[:message] = "Successfully created new user #{@user.name} with ID #{@user.id}"
        session[:user_id] = @user.id

        redirect_to root_path

      else
        flash.now[:status] = :failure
        flash.now[:message] = "Unable to create user"
        flash.now[:details] = @user.errors.messages

        render :login_form, status: :bad_request
      end
    end

  end

  def logout
    session[:user_id] = nil
    reset_session

    flash[:status] = :success
    flash[:message] = "Succesfully logged out"
    redirect_to root_path

  end

  private

  def user_params
    return params.require(:user).permit(:name)
  end
end
