class UsersController < ApplicationController
  def index
    @users = User.order('created_at ASC')
  end

  def show
    @user = User.find_by(id: params[:id])

    render_404 unless @user
  end

  # def new
  #   @user = User.new
  # end

  def create
    # @user = User.new(user_params)
    #
    # if @user.save
    #   flash[:success] = "Successfully created new user #{@user.name} with ID #{@user.id}"
    #   redirect_to root_path
    # else
    #   render :new
    # end

  end

  def login_form
    @user = User.new
    # does nothing; renders view only
  end

  # creates a user if doesn't already exist
  def login
    @user = User.find_by(id: params[:id])

    if @user
      session[:user_id] = @user.id
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
        # flash[:details] = "MORE INFO HERE"

        render :new
      end
    end

  end


  private

  def user_params
    return params.require(:user).permit(:name)
  end
end
