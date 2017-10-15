class SessionsController < ApplicationController

  def create
    name = params[:name]
    @user = User.find_by(name: name)

    if @user
      session[:logged_in_session] = @user.id
      flash[:status] = :success
      flash[:message] = "Successfully logged in as existing user #{@user.name}"

      redirect_to root_path
    else
      new_user_for_session(name)
    end
  end

  def login_form
  end

  def destroy
    #session[:logged_in_session] = nil
    reset_session
    flash[:message] = "Successfully Logged Out"

    redirect_to root_path
  end

  private

  def new_user_for_session(name)
    @user = User.new(name: name)

    if @user.save
      session[:logged_in_session] = @user.id
      flash[:status] = :success
      flash[:message] = "Successfully created new user #{@user.name} with ID #{@user.id}"

      redirect_to root_path
    else
      flash[:status] = :failure
      flash[:details] = @user.errors.messages

      render :login_form, status: :bad_request
    end
  end
end

#   def create
#     user_data = {
#       user: {
#         name: params[:name]
#       }
#     }
#     redirect_to user_path(user_data), method: post
#   end
#
#
#
# if !user
#   new_user = create
#   session[:logged_in_session] = new_user.id
#   flash[:new_success] = "Successfully created new user #{new_user.name} with ID #{new_user.id}"
#   redirect_to root_path
# end
# Successfully created new user 1231233123213123123 with ID 357
#
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
