class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  protected

  def save_and_flash(model)
    result = model.save

    if result
      flash[:status] = :success
      flash[:message] = "Successfully saved #{model.class} #{model.id}"
    else
      flash[:status] = :failure
      flash[:message] = "Could not create #{model.class}"
      flash[:details] = model.errors.messages
    end
    return result
  end

  def not_logged_in_msg
    flash.now[:status] = :failure
    flash.now[:message] = "You must be logged in to do that"
  end

end
