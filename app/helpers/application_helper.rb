module ApplicationHelper

  # Хелпер для определения, активен ли определённый пункт меню.
  def active_class(paths = [])
    paths = [paths] if paths.class != Array
    return "active" if paths.include?(request.fullpath)
    return ""
  end

  
  # Класс для выделения цветом пункта меню "Создать", если на сегодня ещё не все карточки созданы.
  def create_class
    return "toDo" if current_user.flashcards.created_on(current_date).size < current_user.daily_limit
    return ""
  end

  
  # Класс для выделения цветом пункта меню "Повторить" в зависимости от того, всё ли запланированное на сегодня повторено.
  def repeat_class
    return "toDo" if current_user.repetitions.planned.for(current_date).size > 0
    return "inactive"
  end


  # Метод для дебага.
  def planned_repetitions_count_by_date
    Hash[current_user.repetitions.planned_count_by_date.sort] if current_user.present?
  end


  # Хелпер для вывода сообщения об ошибке сохранения в базу.
  def errors(object)
    if object.present?
      message = "<ul>".html_safe
      object.errors.full_messages.each do |msg|
        message += "<li>#{msg}</li>".html_safe
      end
      return message + "</ul>".html_safe
    end
  end
end
