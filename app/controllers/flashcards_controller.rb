# coding: UTF-8

class FlashcardsController < ApplicationController
  
  before_filter :confirm_logged_in
  before_filter :get_flashcard, :only => [:show, :edit, :update, :destroy]
  
  def index
    @dates = current_user.flashcards.all_dates_when_flashcards_were_created.reverse
    @flashcards = {}
    @dates.each do |date|
      @flashcards[date] = current_user.flashcards.created_on(date).reverse
    end
    # @flashcards = current_user.flashcards.order("created_at DESC")
    
    # TODO убрать это информационное сообщение.
    flash[:notice] = current_user.repetitions.planned_count_by_date
  end
  
  
  def new
    @flashcard = current_user.flashcards.new
    render :form
  end
  
  
  def create
    @flashcard = current_user.flashcards.new(params[:flashcard])
    if @flashcard.save
      redirect_to new_flashcard_path
    else
      flash[:notice] = "Не получилось сохранить карточку. Проверьте правильность ввода."
      render :form
    end
  end
  
  
  def show
    
  end
  
  
  def edit
    render :form
  end
  
  
  def update
    if @flashcard.update_attributes(params[:flashcard])
      redirect_to @flashcard
    else
      flash[:notice] = "Не получилось сохранить карточку. Проверьте правильность ввода."
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
      flash[:notice] = "У вас нет доступа к этой карточке."
      redirect_to flashcards_path
    end
  end
  
end