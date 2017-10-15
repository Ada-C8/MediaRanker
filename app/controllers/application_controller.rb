class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

protected
  def save_and_flash(model, edit: "created", save: model.save)
    result = save
    if result
      flash[:status] = :success
      flash[:message] = "Successfully #{edit} #{model.category} #{model.id}"
    else
      flash.now[:status] = :failure
      flash.now[:message] = "A problem occurred: Could not create #{model.category}"
      flash.now[:details] = model.errors.messages
      return false
    end
  end
end
