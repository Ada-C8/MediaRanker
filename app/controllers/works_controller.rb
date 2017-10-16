class WorksController < ApplicationController
  def index
    @works = all_works_by_category
  end

  def show
    find_work
    render_404 if !@work
  end

  def edit
    find_work
    require_owner(@work)
  end

  def update
    find_work
    redirect_to works_path unless @work
    require_owner(@work)
    if @work.update_attributes work_params
      redirect_to work_path(@work.id)
      flash[:success] = "Successfully updated #{@work.category} #{@work.id}"
    else
      flash.now[:error] = "Media was not updated successfully"
      render :edit
    end
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new work_params
    if @work.save
      flash[:success] = "Work added successfully"
      redirect_to works_path
    else
      flash.now[:error] = "Work not added successfully"
      render :new
    end
  end

  def destroy
    find_work
    return if require_owner(@work)
    if !@work
      render_404
      return
    end
    deleted_work = "#{@work.category} #{@work.id}"
    # destroy_votes(@work)
    if @work.destroy
      flash[:success] = "Successfully destroyed #{deleted_work}"
      redirect_to root_path
    else
      flash.now[:error] = "Work was not successfully destroyed"
      render :show
    end
  end

  def upvote
    find_work
    if !@work
      render_404
      return
    end
    if does_vote_exist(@work)
      flash[:error] = "You've already upvoted this!"
      redirect_to work_path(@work.id)
    elsif !(@session_user)
      flash[:error] = "You must be logged in to upvote"
      redirect_to root_path
    else
      Vote.create(user_id: @session_user.id, work_id: @work.id)
      flash[:success] = "Successfully upvoted!"
      redirect_to work_path(@work.id)
    end
  end
end

private
def all_works_by_category
  works = Work.order(:title).group_by { |work| work.category }
  return works
end

def all_works_by_votes
  works = all_works_by_category
  works = works.each do |key, values|
    works[key] = (values.sort_by {|value| value.votes.length}).reverse
  end
  return works
end

def work_params
  return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
end

def find_work
  @work = Work.find_by(id: params[:id])
end

def render_404
  render file: "/public/404.html", status: 404
end

def does_vote_exist(input_work)
  # binding.pry
  session_id = session[:user_id]
  input_work_id = input_work.id
  all_votes = Vote.all.group_by{|vote| vote.user_id}
  if all_votes[session_id]
    user_votes = all_votes[session_id].group_by {|vote| vote.work_id}
    if user_votes[input_work_id]
      return true
    else
      return false
    end
  end
  return false
end

def require_owner(input_work)
  if input_work.user != @session_user
    flash[:error] = "Works can only be deleted by their owners"
    redirect_to work_path(input_work.id)

  end
end

# def destroy_votes(input_work)
#   all_votes = Vote.all.group_by{|vote| vote.work_id}
#   input_id = input_work.id.to_s.to_sym
#   if all_votes[input_id]
#     all_votes[input_id]. each {|vote| vote.destroy}
#   end
# end
