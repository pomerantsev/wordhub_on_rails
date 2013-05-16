# coding: UTF-8

class RepetitionsController < ApplicationController
  
  before_filter :confirm_logged_in
  before_filter :confirm_repetition_validity, :only => :update
  
  def index
    @repetitions = current_user.repetitions.planned.for(current_date)
    if params[:view] && params[:repetition_id]
      @current_repetition = Repetition.find_by_id(params[:repetition_id])
      if @repetitions.include?(@current_repetition)
        if params[:view] == "front"
          @current_text = @current_repetition.flashcard.front_text
          @current_view = "front"
          @reverse_text = @current_repetition.flashcard.back_text
          @reverse_view = "back"
        else
          @current_text = @current_repetition.flashcard.back_text
          @current_view = "back"
          @reverse_text = @current_repetition.flashcard.front_text
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
      
    else
      flash[:error] = "Не получилось записать результат повтора. Попробуйте ещё раз."
    end
    redirect_to repetitions_path
  end



  private

  def init_default_view
    if (!@repetitions.empty?)
      @current_repetition = @repetitions[rand(0...@repetitions.size)]
      @current_text = @current_repetition.flashcard.front_text
      @current_view = "front"
      @reverse_text = @current_repetition.flashcard.back_text
      @reverse_view = "back"
    else
      redirect_to flashcards_path
    end
  end
  
  
  def confirm_repetition_validity
    @current_repetition = Repetition.find_by_id(params[:id])
    unless current_user.repetitions.planned.for(current_date).include?(@current_repetition)
      redirect_to repetitions_path
      return false
    end
    return true
  end

  
end


