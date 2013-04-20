# coding: UTF-8

class RepetitionsController < ApplicationController
  
  before_filter :confirm_logged_in
  
  def index
    @repetitions = current_user.repetitions_for_today
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
    
  end



  private

  def init_default_view
    @current_repetition = @repetitions[rand(0...@repetitions.size)]
    @text = @current_repetition.flashcard.front_text
    @reverse_view = "back"
  end

  
end


