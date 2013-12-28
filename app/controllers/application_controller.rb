class ApplicationController < ActionController::Base
  include ApplicationHelper

  protect_from_forgery with: :exception

  after_action :set_csrf_cookie_for_ng

  before_action :set_locale
  before_action :adjust_current_date
  before_action :wipe_deleted_flashcards

  helper_method :current_user
  helper_method :logged_in?
  helper_method :current_date
  helper_method :home_page

  def index
    if logged_in?
      redirect_to new_flashcard_path
    end
  end

  def logged_in?
    not session[:user_id].nil?
  end

  def current_date
    session[:date]
  end

  def home_page
    new_flashcard_url
  end

  protected

  def confirm_logged_in
    if logged_in?
      # If any repetitions are left from previous dates,
      # we are moving all repetitions.
      current_user.repetitions.adjust_dates(current_date)
      return true
    else
      respond_to do |format|
        format.html do
          flash[:error] = I18n.t("flash.sign_in")
          redirect_to root_url
          return false
        end
        format.json { head :unauthorized }
      end
    end
  end

  def current_user
    User.find_by_id session[:user_id]
  end  



  private

  def set_locale
    I18n.locale = current_user.try(:interface_language) ||
                    extract_locale_from_tld ||
                      I18n.default_locale
  end

  # We update the current date and store it in the session,
  # to be sure that all application uses the same date.
  def adjust_current_date
    session[:date] = Date.today
    return true
  end

  def wipe_deleted_flashcards
    if current_user
      flashcards_deleted_before_today = current_user.flashcards.deleted_before(current_date)
      flashcards_deleted_before_today.each { |flashcard| flashcard.destroy }
    end
  end

  def extract_locale_from_tld
    tld = request.host.split('.').last
    case tld
    when "com", "org" then :en
    when "ru" then :ru
    end
  end

  def set_csrf_cookie_for_ng
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end

  def verified_request?
    super || form_authenticity_token == request.headers['HTTP_X_XSRF_TOKEN']
  end

end
