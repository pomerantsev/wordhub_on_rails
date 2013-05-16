# coding: UTF-8

class FlashcardsController < ApplicationController
  
  before_filter :confirm_logged_in
  before_filter :get_flashcard, only: [:show, :edit, :update, :destroy]
  
  def index
    @flashcards_grouped_by_date = current_user.flashcards.grouped_by_date
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
  

  def show
  end
    

  def edit
    @page_title = "Редактирование карточки"
    render :form
  end
  

  def update
    if @flashcard.update_attributes(params[:flashcard])
      redirect_to @flashcard
    else
      flash.now[:error] = errors(@flashcard)
      render :form
    end
  end
  
  
  def destroy
    @flashcard.destroy
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