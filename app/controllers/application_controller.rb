class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  #methods in application_controller cant be accesed in view pages
  #helper_method will allow access of this methods in the view pages
  helper_method :current_user, :logged_in?
  
  #this methods are available to all controller files but not views files
  def current_user
    #returns current_user if already exists if not ||= find user with current session_id
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def logged_in?
    #!! converts this current_user to a boolean
    !!current_user
  end
  
  def require_user
    if !logged_in?
      flash[:danger] = "You must be logged in to do that!"
      redirect_to root_path
    end
  end
  
   def current_controller?(names)
    names.include?(current_controller)
  end
  
end
