class ApplicationController < ActionController::Base
  protect_from_forgery
  
  protected
  
  def confirm_logged_in
    unless session[:user_id]
      redirect_to :controller => "application", :action => "index"
      return false # halts the before_filter
    else
      return true
    end
  end
  
  def current_user
    User.find session[:user_id]
  end
  
  
  
end
