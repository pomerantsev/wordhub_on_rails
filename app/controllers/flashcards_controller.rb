class FlashcardsController < ApplicationController

  before_action :confirm_logged_in
  before_action :get_flashcard, only: [:show, :edit, :update, :destroy]

  def index
    @batch_size = Kaminari.config.default_per_page
    @flashcards = current_user.flashcards.order(created_at: :desc)
    if @search_string = params[:search]
      @flashcards = @flashcards.where(
        Flashcard.arel_table[:front_text].matches("%#{@search_string}%").or(
        Flashcard.arel_table[:back_text].matches("%#{@search_string}%")))
    end
    @total = @flashcards.count
    @flashcards = @flashcards.page(params[:page])
    @flashcards_grouped_by_date = @flashcards.grouped_by_date
    @deleted_flashcards = current_user.flashcards.deleted
    # just_deleted is a boolean value that is used to determine
    # if the 'deleted flashcards' block should be highlighted.
    @just_deleted = session[:just_deleted]
    session[:just_deleted] = nil
    respond_to do |format|
      format.html
      format.json { render 'flashcards/index' }
    end
  end
  
  def new
    @flashcard = current_user.flashcards.new
    @page_title = I18n.t("flashcards.new.title")
  end

  def create
    @flashcard = current_user.flashcards.new(flashcard_params)
    respond_to do |format|
      format.html do
        if @flashcard.save
          redirect_to new_flashcard_path
        else
          flash.now[:error] = errors(@flashcard)
          render :new
        end
      end
      format.json do
        if @flashcard.save
          response.status = :created
          render 'flashcards/show'
        else
          render json: @flashcard.errors, status: :unprocessable_entity
        end
      end
    end
  end

  def show
    respond_to do |format|
      format.json { render 'flashcards/show' }
    end
  end

  def edit
    @page_title = I18n.t("flashcards.edit.title")
  end

  def update
    respond_to do |format|
      format.html do
        if @flashcard.update_attributes(flashcard_params)
          redirect_to flashcards_path(anchor: @flashcard.id)
        else
          flash.now[:error] = errors(@flashcard)
          render :edit
        end
      end
      format.json do
        if @flashcard.update_attributes(flashcard_params)
          head :no_content
        else
          render json: @flashcard.errors, status: :unprocessable_entity
        end
      end
    end
  end

  def destroy
    @flashcard.update_attribute(:deleted, true)
    respond_to do |format|
      format.html do
        session[:just_deleted] = true
        redirect_to flashcards_path
      end
      format.json { head :no_content }
    end
  end


  def undelete
    if params[:flashcards].present?
      all_flashcards_belong_to_current_user = params[:flashcards].all? do |id|
        current_user.flashcards.deleted_and_not_deleted.find_by_id(id).present?
      end
      if all_flashcards_belong_to_current_user
        params[:flashcards].each do |id|
          flashcard = current_user.flashcards.deleted.find_by_id(id)
          unless flashcard.nil?
            flashcard.update_attribute(:deleted, false)
          end
        end
      else
        flash[:error] = I18n.t("flash.no_access_to_flashcards")
      end
    end

    respond_to do |format|
      format.html do
        if params[:flashcards].blank? || all_flashcards_belong_to_current_user
          redirect_to flashcards_path
        else
          redirect_to home_page
        end
      end
      format.json { head :no_content }
    end
  end

protected

  def get_flashcard
    @flashcard = Flashcard.find_by_id(params[:id])
    if @flashcard.nil? || @flashcard.user != current_user
      respond_to do |format|
        format.html do
          flash[:error] = I18n.t("flash.no_access_to_single_flashcard")
          redirect_to home_page
        end
        format.json { head :unauthorized }
      end
    end
  end



private

  def flashcard_params
    params.require(:flashcard).permit(:front_text, :back_text, :deleted)
  end

end
