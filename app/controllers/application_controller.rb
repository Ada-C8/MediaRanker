class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  def save_flash(model)
    saved = model.save

    if saved
      flash[:status] = :success
      flash[:message] = "Successfully saved #{model.class} #{model.id}"
    else
      flash[:status] = :failure
      flash[:message] = "Failed to save #{model.class}"
      flash[:details] = model.errors.messages
    end # if/else

    return saved 
  end # save_flash
end
