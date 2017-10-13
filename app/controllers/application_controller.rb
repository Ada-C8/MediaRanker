class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

protected
  def save_and_flash(model, message_variation)
    result = model.save
    if result
      flash[:status] = :success
      flash[:message] = "Successfully #{message_variation}d #{model.title}"
    else
      flash.now[:status] = :failure
      flash.now[:message] = "Failed to #{message_variation} #{model.title}"
      flash.now[:details] = model.errors.messages
    end

    return result
  end
end
