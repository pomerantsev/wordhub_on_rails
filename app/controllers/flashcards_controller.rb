# coding: UTF-8

class FlashcardsController < ApplicationController
  
  before_action :confirm_logged_in
  before_action :get_flashcard, only: [:edit, :update, :destroy]
  
  def index
    @flashcards = current_user.flashcards.order(created_at: :desc).page(params[:page])
    if @search_string = params[:search]
      @flashcards = @flashcards.where(
        Flashcard.arel_table[:front_text].matches("%#{@search_string}%").or(
        Flashcard.arel_table[:back_text].matches("%#{@search_string}%")))
    end
    @flashcards_grouped_by_date = @flashcards.grouped_by_date
    @deleted_flashcards = current_user.flashcards.deleted
    # just_deleted - boolean-значение, используемое, чтобы определить,
    # нужно ли подсвечивать блок удалённых карточек.
    @just_deleted = session[:just_deleted]
    session[:just_deleted] = nil
  end
  
  
  def new
    @flashcard = current_user.flashcards.new
    @page_title = I18n.t("flashcards.form.new")
    render :form
  end
  
  
  def create
    @flashcard = current_user.flashcards.new(flashcard_params)
    if @flashcard.save
      redirect_to new_flashcard_path
    else
      flash.now[:error] = errors(@flashcard)
      render :form
    end
  end
    

  def edit
    @page_title = I18n.t("flashcards.form.edit")
    render :form
  end
  

  def update
    if @flashcard.update_attributes(flashcard_params)
      redirect_to flashcards_path(anchor: @flashcard.id)
    else
      flash.now[:error] = errors(@flashcard)
      render :form
    end
  end
  
  
  def destroy
    @flashcard.update_attribute(:deleted, true)
    session[:just_deleted] = true
    redirect_to flashcards_path
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
        redirect_to flashcards_path
      else
        flash[:error] = I18n.t("flash.no_access_to_flashcards")
        redirect_to home_page
      end
    else
      redirect_to flashcards_path
    end
  end
  
  

protected
  
  def get_flashcard
    @flashcard = Flashcard.find_by_id(params[:id])
    if @flashcard.nil? || @flashcard.user != current_user
      flash[:error] = I18n.t("flash.no_access_to_single_flashcard")
      redirect_to home_page
      return false
    end
    return true
  end



private
  
  def flashcard_params
    params.require(:flashcard).permit(:front_text, :back_text, :deleted)
  end
  
end
