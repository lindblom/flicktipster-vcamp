class ApplicationController < ActionController::Base
  # protect_from_forgery
  
  helper_method :current_user, :logged_in?, :admin?
  
  private
    def current_user
      @current_user ||= User.find_by_id(cookies.signed[:user_id])
    end
    
    def logged_in?
      !!current_user
    end
    
    def admin?
      logged_in? && current_user.admin?
    end
end
