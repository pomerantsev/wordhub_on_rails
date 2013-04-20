class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :current_user
  
  def index
    if logged_in
      redirect_to flashcards_path
    end
  end
  

  
  protected
  
  def logged_in
    return session[:user_id]
  end
  
  def confirm_logged_in
    unless logged_in
      redirect_to root_url
      return false # halts the before_filter
    else
      return true
    end
  end
  
  def current_user
    User.find session[:user_id]
  end  
  
end
