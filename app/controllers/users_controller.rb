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

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save!
      redirect_to root_path
    else
      render :new, status: :bad_request
    end
  end

  def login
    name = params[:user][:name]
    puts "************"
    puts name
    unless name
      flash.now[:status] = :failure
      flash.now[:message] = "Username can't be blank"
      render :login_form
      return
    end
    @user = User.find_by(name: name)
    if @user
      session[:logged_in_user] = @user.id
      redirect_to root_path
    else
      create
    end
  end


  #do not need these?
  def update
  end
  def destroy
  end
  def edit
  end

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
