module ApplicationHelper

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in
    !!current_user
  end

  def error_parser(hash)
    "#{hash[0].to_s} #{hash[1][0]}"
  end
end
