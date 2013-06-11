# coding: UTF-8

class RepetitionsController < ApplicationController
  
  before_filter :confirm_logged_in
  before_filter :confirm_repetition_validity, only: :update
  

  # Индексный метод служит для получения одного случайного повтора.
  def index
    @repetitions = current_user.repetitions.planned.for(current_date)
    if params[:view] && params[:repetition_id]
      @current_repetition = Repetition.find_by_id(params[:repetition_id])
      if @repetitions.include?(@current_repetition)
        set_texts_and_views(params[:view])
      else
        init_default_view
      end
    else
      init_default_view
    end
  end
  

  # Сохраняет повтор как успешный или неуспешный. 
  def update
    @current_repetition.successful = params[:successful]
    unless @current_repetition.save
      flash[:error] = errors(@current_repetition)
    end
    redirect_to repetitions_path
  end



  private

  # current_side будет чаще равняться "front", это дефолтный случай для браузера со включённым JS-ом.
  # Второй вариант (без JS) предполагает передачу стороны карточки в параметрах адреса.
  def set_texts_and_views(current_side)
    if current_side == "front"
      @current_text = @current_repetition.flashcard.front_text
      @current_view = "front"
      @reverse_text = @current_repetition.flashcard.back_text
      @reverse_view = "back"
    elsif current_side == "back"
      @current_text = @current_repetition.flashcard.back_text
      @current_view = "back"
      @reverse_text = @current_repetition.flashcard.front_text
      @reverse_view = "front"
    end
  end


  # Выбирает случайный повтор из всех запланированных на сегодня.
  # Если повторов нет - редиректит на список карточек.
  def init_default_view
    if (!@repetitions.empty?)
      @current_repetition = @repetitions[rand(0...@repetitions.size)]
      set_texts_and_views("front")
    else
      redirect_to stats_path
    end
  end
  
  
  # При обновлении информации о повторе (повтор выполнен) проверяется, запланирован ли он на сегодня.
  def confirm_repetition_validity
    @current_repetition = Repetition.find_by_id(params[:id])
    unless current_user.repetitions.planned.for(current_date).include?(@current_repetition)
      redirect_to repetitions_path
      return false
    end
    return true
  end

  
end


