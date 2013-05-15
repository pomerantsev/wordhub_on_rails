class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :adjust_current_date
  
  helper_method :current_user
  helper_method :logged_in
  
  def index
    if logged_in
      redirect_to flashcards_path
    end
  end
  
  def logged_in
    session[:user_id]
  end


  
  protected
  
  def confirm_logged_in
    if logged_in
      current_user.repetitions.adjust_dates(session[:date])
      return true
    else
      redirect_to root_url
      return false
    end
  end

  def current_user
    User.find_by_id session[:user_id]
  end  



  private

  # Чтобы всё приложение вычисляло дату единым образом, используется одна переменная сессии.
  def adjust_current_date
      session[:date] = Date.today
  end
  
end
