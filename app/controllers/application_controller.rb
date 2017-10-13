class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # def save_and_flash(model, message: "Failed to save")
  def save_and_flash(model)
    result = model.save
    if result
      flash[:status] = :success
      flash[:message] = "Successfully saved #{model.class} number #{model.id}"
    else
      flash.now[:status] = :failure
      flash.now[:message] = "Failed to save #{model.class}"
      flash.now[:details] = model.errors.messages
    end
    return result
  end
end
