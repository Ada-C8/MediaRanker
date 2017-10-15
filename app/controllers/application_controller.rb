class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

protected
  def save_and_flash(model, edit: "created", save: model.save)
    result = save
    if result
      flash[:status] = :success
      specific = model.class == User ? "user #{model.name} with ID" : "#{model.category}"
      flash[:message] = "Successfully #{edit} #{specific} #{model.id}"
    else
      flash.now[:status] = :failure
      specific = model.class == User ? "log in" : "create #{model.category}"
      flash.now[:message] = "A problem occurred: Could not #{specific}"
      flash.now[:details] = model.errors.messages
      return false
    end
  end
end
