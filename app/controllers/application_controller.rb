class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def save_and_flash(model)
    result = model.save
    if result
      flash[:status] = :success
      flash[:message] = "Successfully saved #{model.class} #{model.id}"
    else
      flash[:status] = :failure
      flash[:message] = "Failed to save #{model.class} #{model.id}"
      flash[:details] = model.errors.messages
    end
    return result
  end
end
