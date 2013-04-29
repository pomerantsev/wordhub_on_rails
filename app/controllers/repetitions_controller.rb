# coding: UTF-8

class RepetitionsController < ApplicationController
  
  before_filter :confirm_logged_in
  before_filter :confirm_repetition_validity, :only => :update
  
  def index
    
    # Это для тестирования даты
    if !params[:date].nil?
      session[:date] = Date.civil(params[:date][:year].to_i, params[:date][:month].to_i, params[:date][:day].to_i)
    end
    
    # Это для статистики
    @planned_repetitions_count_by_date = current_user.planned_repetitions_count_by_date
    flash[:notice] = @planned_repetitions_count_by_date.inspect
    
    # session[:date] - тоже уберётся потом. Сейчас нужна, чтобы выставлять "текущую" дату.
    @repetitions = current_user.planned_repetitions_for_date(session[:date])
    if params[:view] && params[:repetition_id]
      @current_repetition = Repetition.find_by_id(params[:repetition_id])
      if @repetitions.include?(@current_repetition)
        if params[:view] == "front"
          @text = @current_repetition.flashcard.front_text
          @reverse_view = "back"
        else
          @text = @current_repetition.flashcard.back_text
          @reverse_view = "front"
        end
      else
        init_default_view
      end
    else
      init_default_view
    end
  end
  
  def update
    @current_repetition.run = true
    @current_repetition.successful = params[:successful]
    if @current_repetition.save
      # Сюда сейчас выводятся всякие значения, которые требуются для исследования.
      flash[:notice] = @current_repetition.inspect + @current_repetition.flashcard.consecutive_successful_repetitions.to_s
    else
      flash[:notice] = "Не получилось записать результат повтора. Попробуйте ещё раз."
    end
    redirect_to repetitions_path
  end



  private

  def init_default_view
    if (!@repetitions.empty?)
      @current_repetition = @repetitions[rand(0...@repetitions.size)]
      @text = @current_repetition.flashcard.front_text
      @reverse_view = "back"
    else
      
      # Вообще-то здесь должен быть редирект.
      #redirect_to flashcards_path
      flash[:notice] = "На эту дату повторов нет."
    end
  end
  
  
  def confirm_repetition_validity
    @current_repetition = Repetition.find(params[:id])
    
    if @current_repetition.flashcard.user != current_user || !current_user.planned_repetitions_for_date(session[:date]).include?(@current_repetition)
      redirect_to repetitions_path
    end
    
  end

  
end


