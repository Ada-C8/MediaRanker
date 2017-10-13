class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

protected
  def save_and_flash(model)
    result = model.save
    if result
      flash[:status] = :success
      flash[:message] = "Successfully saved #{model.title}"
    else
      flash.now[:status] = :failure
      flash.now[:message] = "Failed to save #{model.title}"
      flash.now[:details] = model.errors.messages
    end

    return result
  end
end
