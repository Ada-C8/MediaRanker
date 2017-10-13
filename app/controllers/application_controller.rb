class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  protected
  def save_and_flash(model, message_success, message_fail)
    result = model.save
    if result
      flash[:status] = :success
      flash[:message] = "Successfully #{message_success} #{model.category} #{model.id}"
    else
      flash.now[:status] = :failure
      flash.now[:message] = "Could not #{message_fail} #{model.category}"
      flash.now[:details] = model.errors.messages
    end
    return result
  end
end
