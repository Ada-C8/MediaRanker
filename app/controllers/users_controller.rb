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

    if @user.save
      #success message
      flash[:status] = :success
      flash[:message] = "Successfully created user #{@user.id}"
      redirect_to root_path
    else
      #I'm not sure how we're deciding to do error messages.  Flash?
      flash.now[:status] = :failure
      flash.now[:message] = "Failed to create user"
      flash.now[:details] = @user.errors.messages
      render :new, status: :bad_request
    end
  end

  def edit
    @user = User.find(params[:id])
    return head :not_found unless @user
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
    auth_hash = request.env['omniauth.auth']
    user = User.find_by(oauth_uid: auth_hash['uid'], oauth_provider: auth_hash['provider'])

    unless user
      user = User.by_auth_hash(auth_hash)
      unless user.save
        flash.now[:status] = :failure
        flash.now[:result_text] = "Not logged in"
        flash.now[:messages] = user.errors.messages
        return redirect_to root_path
      end
    end
    session[:user] = user
    redirect_to root_path
  end

  private

  # def user_params
  #   return params.permit(:name, :email)
  # end
  def user_params
    return params.require(:user).permit(:name, :email, :oauth_uid, :oauth_provider)
  end


end
