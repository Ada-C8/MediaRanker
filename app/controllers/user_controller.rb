class UserController < ApplicationController


    def new
      # use strong params to limit the fields that the user can populate with data
      @user = User.new
    end

    def create
      @user = User.new(user_params)
      if @user.save
        redirect_to users_path
      else
        render :new
      end
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
      redirect_to users_path
    end

    private

    def user_params
      return params.permit(:name, :email)
    end


  def login
    user_id = params[:user][:user_id]
    user = User.find_by(id: user_id)

    if user
      session[:logged_in_user] = author_id
      redirect_to root_path
    else
      head :not_found
    end
  end

end
