class RepetitionsController < ApplicationController
  
  before_action :confirm_logged_in
  before_action :confirm_repetition_validity, only: :update

  # The index method is used for getting one random repetition.
  def index
    @repetitions = current_user.repetitions.planned.for(current_date)
    respond_to do |format|
      format.html do
        if (!@repetitions.empty?)
          @current_repetition = @repetitions[rand(0...@repetitions.size)]
          @current_flashcard = @current_repetition.flashcard
        else
          redirect_to stats_path
        end
      end
      format.json { render 'repetitions/index' }
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
