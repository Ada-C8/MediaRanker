class SessionsController < ApplicationController
  # def create
  #   @user = User.new(name: params[:name])
  #   @user.save
  #   return @user
  # end

  def login
    name = params[:name]
    user = User.find_by(name: name)

    if user
      session[:logged_in_session] = user.id
      flash[:logged_in] = "Successfully logged in as existing user #{user.name}"
      redirect_to root_path
    else
      redirect_to user_path(user: name), method: post
    end
  end

  def logout
    session[:logged_in_session] = nil
    flash[:logged_out] = "Successfully Logged Out"
    redirect_to root_path
  end
end

# if !user
#   new_user = create
#   session[:logged_in_session] = new_user.id
#   flash[:new_success] = "Successfully created new user #{new_user.name} with ID #{new_user.id}"
#   redirect_to root_path
# end
#Successfully created new user 1231233123213123123 with ID 357

# def login
#  +    name = params[:author][:name]
#  +
#  +    # Double check that this author exists
#  +    author = Author.find_by(name: name)
#  +    if author
#  +      session[:logged_in_author] = author.id
#  +      redirect_to books_path
#  +    else
#  +      flash[:status] = :failure
#  +      flash[:message] = "No author found with name #{name}"
#  +      render :login_form
#  +    end
