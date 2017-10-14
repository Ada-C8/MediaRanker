class MediaInstancesController < ApplicationController
  def index
    @media_instances = MediaInstance.all
  end

  def show
    binding.pry
    @media_instance = MediaInstance.find(params[:id])
  end


  def new

    # use strong params to limit the fields that the user can populate with data
    @media_instances = MediaInstance.all
    @media_instance = MediaInstance.new
    if @media_instance.save
      flash[:status] = :success
      flash[:message] = "Successfully created media #{@media_instance.id}"
      redirect_to media_instances_path
    else
      # Tell the user what went wrong
      flash.now[:status] = :failure
      flash.now[:message] = "Failed to create media"
      flash.now[:details] = @media_instance.errors.messages
      render :new, status: :bad_request
    end
  end

  def create
    @media_instances = MediaInstance.all
    @media_instance = MediaInstance.new(media_instance_params)
    if @media_instance.save
      flash[:status] = :success
      flash[:message] = "Successfully created Media Instance #{@media_instance.id}"
      redirect_to media_instances_path
    else
      # Tell the user what went wrong
      flash.now[:status] = :failure
      flash.now[:message] = "Failed to create media"
      flash.now[:details] = @media_instance.errors.messages
      render :new, status: :bad_request
    end

  end

  def edit
    @media_instances = MediaInstance.all
    @media_instance = MediaInstance.find(params[:id])
  end

  def update
    @media_instance = MediaInstance.find(params[:id])
    @media_instance.update_attributes(media_instance_params)
    if @media_instance.save
      redirect_to media_instance_path
    else
      render :edit
    end
  end

  def destroy
    current_user = nil
    if session[:logged_in_user]
      current_user = User.find_by(id:session[:logged_in_user])

      @media_instance.destroy
      flash[:status] = :success
      flash[:message] = "Deleted media #{@media_instance.id}"
      redirect_to media_instances_path
    end
    @media_instance.destroy
    flash[:status] = :success
    flash[:message] = "Deleted media #{@media_instance.id}"

    redirect_to media_instances_path
  end

  def self.get_music
      @media_instances = MediaInstance.where(media_type: "music")
  end

  def self.ten_music
    get_music.first(10).order(@media_instance.votes.length)
  end

  def self.get_news
    @media_instances = MediaInstance.where(media_type: "news")
  end

  def self.ten_news
    get_news.first(10).order(@media_instance.votes.length)
  end

  def get_books
    @media_instances = MediaInstance.where(media_type: "book")
  end

  def self.ten_books
    get_books.first(10).order(@media_instance.votes.length)
  end

  def num_votes
    Vote.where(media_instance_id: @media_instance.id).length
  end
  private

  def media_instance_params
    return params.require(:media_instance).permit(:media_type, :title, :creator, :pub_yr, :details)
  end


end
