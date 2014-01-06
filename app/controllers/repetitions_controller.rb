class RepetitionsController < ApplicationController
  
  before_action :confirm_logged_in
  before_action :load_and_authorize, only: :update

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
    valid_for_update = current_user.repetitions.planned.for(current_date).include?(@repetition)
    respond_to do |format|
      format.html do
        if valid_for_update
          @repetition.update_attributes(repetition_params)
        end
        redirect_to repetitions_path
      end
      format.json do
        if valid_for_update
          @repetition.update_attributes(repetition_params)
          head :no_content
        else
          render json: @repetition.errors, status: :unprocessable_entity
        end
      end
    end
  end



  private

  def repetition_params
    params.require(:repetition).permit(:successful)
  end

  def load_and_authorize
    @repetition = Repetition.find_by(id: params[:id])
    unless current_user.repetitions.include?(@repetition)
      respond_to do |format|
        format.html { redirect_to repetitions_path }
        format.json { head :unauthorized }
      end
    end
  end
end
