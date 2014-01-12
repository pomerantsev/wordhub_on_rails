module ApplicationHelper

  def current_user
    User.find_by(id: session[:user_id])
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

  def full_title(title = nil)
    base_title = I18n.t("nav.wordhub")
    if title.nil? or title.blank?
      base_title
    else
      "#{title} &mdash; #{base_title}".html_safe
    end
  end

  # Is the menu item active
  def active_class(paths = [])
    # If the param is not an array but a string
    paths = [paths] if paths.class != Array
    return "active" if paths.include?(request.fullpath)
    return ""
  end

  # Highlights the 'create' menu item
  # if the daily limit is not reached.
  def create_class
    return "to-do" if current_user.flashcards.created_on(current_date).size < current_user.daily_limit
    return ""
  end

  # Highlights the 'repeat' menu item
  # if not all flashcards are repeated.
  def repeat_class
    return "to-do" if current_user.repetitions.planned.for(current_date).size > 0
    return "inactive"
  end

  # Shorthand for object.errors.full_messages
  def errors(object)
    if object.present?
      object.errors.full_messages
    end
  end

  def copyright_years
    initial_year = WhRails::Application.config.initial_year
    current_year = Time.now.year
    if initial_year == current_year
      "#{initial_year}"
    else
      "#{initial_year} &mdash; #{current_year}"
    end
  end

  def created_today_by(user)
    user.flashcards.created_on(current_date).size
  end

  def run_today_by(user)
    user.repetitions.run.on(current_date).size
  end

  def planned_for_today_by(user)
    user.repetitions.for(current_date).size
  end

  def user_stats(user)
    [
      user.total_stats,
      user.stats_for_period(30.days),
      user.stats_for_period(1.day)
    ]
  end

end
