class UsersController < ApplicationController


  def new
    # use strong params to limit the fields that the user can populate with data
    @user = User.new
    # if @user.save
    #   flash[:status] = :success
    #   flash[:message] = "Successfully created user #{@user.id}"
    #   redirect_to users_path
    # else
    #   # Tell the user what went wrong
    #   flash.now[:status] = :failure
    #   flash.now[:message] = "Failed to create user"
    #   flash.now[:details] = @user.errors.messages
    #   render :new, status: :bad_request
    # end
  end

  def create
    @user = User.new(user_params)
    # binding.pry
    if @user.save
      flash[:status] = :success
      flash[:message] = "Successfully created user #{@user.id}"
      session[:user_id] = @user.id
      redirect_to root_path
    else
      # Tell the user what went wrong
      flash.now[:status] = :failure
      flash.now[:message] = "Failed to create user"
      flash.now[:details] = @user.errors.messages
      render :new, status: :bad_request
    end
    # if @user.save
    #   redirect_to users_path
    # else
    #   render :new
    # end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update_attributes(user_params)
    if @user.save
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
  end

  def login
    user_id = params[:user][:user_id]
    user = User.find_by(id: user_id)

    if user
      session[:logged_in_user] = user_id
      redirect_to root_path
    else

      head :not_found
    end
  end

  def logout
  session[:user_id] = nil
  redirect_to root_path
  end

  private

  # def user_params
  #   return params.permit(:name, :email)
  # end
  def user_params
    return params.require(:user).permit(:name, :email)
  end


end
