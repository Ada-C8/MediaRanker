class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # def save_and_flash(model)
  #   result = model.save
  #   if result
  #     flash[:status] = :success
  #     flash[:message] = "Successfully saved #{{model.class}}"
  #   else
  #     flash[:status] = :failure
  #     flash[:message] = "faild to save #{model.class}"
  #     flash[:details] = model.errors.messages
  #   end
  # end

  # protected - This class 8 children can call
  # public - other classes can call it
  # private - Only this class can call

  # Is it recommended to use a partial to display errors? or is it better to use a flash message?
  # Recommend to use flash instead of using error partials
  # Use flash.now is only when that action is being displayed
  # controller testing is end to end testing
end
