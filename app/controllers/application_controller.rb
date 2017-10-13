class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
def index

end
protected
  def save_and_flash(model)
    result = model.save
    if result
      flash[:status] = :success
      flash[:message] = "Successfully saved #{model.class} #{model.id}"
    else
      flash.now[:status] = :failure
      flash.now[:message] = "Failed to save #{model.class}"
      flash.now[:details] = model.errors.messages
    end
  end
end
