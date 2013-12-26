class RepetitionsController < ApplicationController
  
  before_action :confirm_logged_in
  before_action :confirm_repetition_validity, only: :update

  # The index method is used for getting one random repetition.
  def index
    @repetitions = current_user.repetitions.planned.for(current_date)
    if params[:repetition_id].present?
      @current_repetition = Repetition.find_by_id(params[:repetition_id])
      if @repetitions.include?(@current_repetition)
        # If there is no :view in params, using 'front' by default.
        set_texts_and_views(params[:view] || "front")
      else
        init_default_view
      end
    else
      init_default_view
    end
  end

  # Saves the repetition as successful or unsuccessful.
  def update
    # If boolean values are passed, it doesn't work.
    # They are left here only for tests.
    # TODO: remove this duplication.
    if [true, false, 'true', 'false'].include?(params[:successful])
      @current_repetition.successful = params[:successful]
      @current_repetition.save
    else
      flash[:error] = I18n.t("flash.invalid_param")
    end
    redirect_to repetitions_path
  end



  private

  # current_side is 'front' by default (for a JS-enabled browser).
  # TODO: remove functionality for non-JS-enabled browsers.
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


  # Selects a random repetition among all planned for today.
  # If no repetitions are available, it redirects to the stats page.
  def init_default_view
    if (!@repetitions.empty?)
      @current_repetition = @repetitions[rand(0...@repetitions.size)]
      set_texts_and_views("front")
    else
      redirect_to stats_path
    end
  end

  # When updating the repetition, we must check
  # if it's planned for today.
  def confirm_repetition_validity
    @current_repetition = Repetition.find_by_id(params[:id])
    unless current_user.repetitions.planned.for(current_date).include?(@current_repetition)
      redirect_to repetitions_path
      return false
    end
    return true
  end
end
