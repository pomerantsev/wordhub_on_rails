# coding: UTF-8

class RepetitionsController < ApplicationController
  
  before_filter :confirm_logged_in
  before_filter :confirm_repetition_validity, :only => :update
  
  def index
    
    @repetitions = current_user.repetitions_left_for_today
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
      redirect_to flashcards_path
    end
  end
  
  
  def confirm_repetition_validity
    @current_repetition = Repetition.find(params[:id])
    if @current_repetition.flashcard.user != current_user || !current_user.repetitions_left_for_today.include?(@current_repetition)
      redirect_to repetitions_path
    end
    
  end

  
end


