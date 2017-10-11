class MediaInstanceController < ApplicationController
  def index
    @media_instances = MediaInstance.all
  end

  def show
    @media_instance = MediaInstance.find(params[:id])
  end

  def new
    # use strong params to limit the fields that the user can populate with data
    @media_instance = MediaInstance.new
  end

  def create
    @media_instance = MediaInstance.new(media_instance_params)
    if @media_instance.save
      redirect_to media_instances_path
    else
      render :new
    end
  end

  def edit
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
    @media_instance = MediaInstance.find(params[:id])
    @media_instance.destroy
    redirect_to media_instances_path
  end

  private

  def media_instance_params
    return params.permit(:media_type, :title, :creator, :pub_yr, :details)
  end

end
