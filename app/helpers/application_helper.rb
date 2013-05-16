module ApplicationHelper
  def active_class(page = {})
    current_controller = true if params[:controller] == page[:controller] || page[:controller].nil?
    current_action = true if page[:action].include?(params[:action]) || page[:action].nil?
    return "active" if current_controller && current_action
    return ""
  end
  
  def create_class
    return "toDo" if current_user.flashcards.created_on(current_date).size < current_user.daily_limit
    return ""
  end
  
  def repeat_class
    return "toDo" if current_user.repetitions.planned.for(current_date).size > 0
    return "inactive"
  end

  def planned_repetitions_count_by_date
    Hash[current_user.repetitions.planned_count_by_date.sort] if current_user.present?
  end

  def errors(object)
    object.errors.full_messages.inspect if object.present?
  end
end
