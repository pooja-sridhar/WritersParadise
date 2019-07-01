class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception



helper_method :current_user, :logged_in?

  def current_user
  	@current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  def logged_in?
  	current_user.present?
  end
 def validate_user
     redirect_to root_path,flash: {danger: "You must be logged in" } unless logged_in?
  end
  
end
