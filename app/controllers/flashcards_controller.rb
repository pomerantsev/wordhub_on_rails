# coding: UTF-8

class FlashcardsController < ApplicationController
  
  before_filter :confirm_logged_in
  before_filter :get_flashcard, only: [:edit, :update, :destroy]
  
  def index
    @flashcards_grouped_by_date = current_user.flashcards.grouped_by_date
    @deleted_flashcards = current_user.flashcards.deleted.order("updated_at ASC")
    @just_deleted = session[:just_deleted]
    session[:just_deleted] = nil
  end
  
  
  def new
    @flashcard = current_user.flashcards.new
    @page_title = "Новая карточка"
    render :form
  end
  
  
  def create
    @flashcard = current_user.flashcards.new(params[:flashcard])
    if @flashcard.save
      redirect_to new_flashcard_path
    else
      flash.now[:error] = errors(@flashcard)
      render :form
    end
  end
    

  def edit
    @page_title = "Редактирование карточки"
    render :form
  end
  

  def update
    if @flashcard.update_attributes(params[:flashcard])
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
      params[:flashcards].each do |id|
        flashcard = current_user.flashcards.deleted.find_by_id(id)
        unless flashcard.nil?
          flashcard.update_attribute(:deleted, false)
        end
      end
    end
    redirect_to flashcards_path
  end
  
  
  protected
  
  def get_flashcard
    @flashcard = Flashcard.find_by_id(params[:id])
    if @flashcard.nil? || @flashcard.user != current_user
      flash[:error] = "У вас нет доступа к этой карточке."
      redirect_to flashcards_path
      return false
    end
    return true
  end
  
end