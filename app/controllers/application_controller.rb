class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :current_user
  helper_method :logged_in
  
  def index
    if logged_in
      redirect_to flashcards_path
    end
  end
  
  def logged_in
    return session[:user_id]
  end
  
  protected
  

  
  def confirm_logged_in
    unless logged_in
      redirect_to root_url
      return false # halts the before_filter
    else
      if session[:date]
        current_user.adjust_repetition_dates(session[:date])
      else
        current_user.adjust_repetition_dates
      end
      return true
    end
  end
  
  def current_user
    User.find session[:user_id]
  end  
  
end
