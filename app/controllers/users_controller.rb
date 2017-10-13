class UsersController < ApplicationController
  def index
    @users = User.all
  end

  # def show
  #   @user = User.find(params[:id])
  # end

  # def new
  #   @user = User.new
  # end
  #
  # def create
  #   @work = Work.new(work_params)
  #   if @work.save
  #     redirect_to works_path
  #   else
  #     render :new, status: :bad_request
  #   end
  # end

  # def login_form
  #
  # end
end
