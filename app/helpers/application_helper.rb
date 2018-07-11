module ApplicationHelper
  def vote_button(instance, user)
    html = ""
    if user
      html = form_for [instance, User.find(user), Vote.new] do |f|
        f.submit "Upvote", class:'success button'
      end
    else
      # binding.pry
      html =  "<br>"
      html += link_to "Upvote", '/auth/github', class:'success button'
    end

    html.html_safe
  end
end
# <%= form_for [instance, User.find(session[:user_id]), Vote.new] do |f| %>
