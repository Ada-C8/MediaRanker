class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

protected
  def save_and_flash(model)
    result = model.save_and_flash
    if result
      flash[:status] = :success
      flash[:message] = "Successfully saved #{model.class} #{model.id}"
    else
      flash.now[:status] = :failure
      flash.now[:message] = "Failed to save #{model.class}"
      flash.now[:details] = model.error.messages
    end
    return result
  end
end
