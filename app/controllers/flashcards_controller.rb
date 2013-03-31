# coding: UTF-8

class FlashcardsController < ApplicationController
  
  def index
    list
    render "list"
  end
  
  
  def list
    @flashcards = current_user.flashcards
  end
  
  
  def new
    @flashcard = current_user.flashcards.new
  end
  
  
  def create
    @flashcard = current_user.flashcards.new params[:flashcard]
    if @flashcard.save
      logger.debug("Front text:" + @flashcard.front_text)
      redirect_to flashcards_path
    else
      flash[:notice] = "Не получилось сохранить карточку. Проверьте правильность ввода."
      render "new"
    end
  end
  
  
  def show
    @flashcard = Flashcard.find params[:id]
  end
  
  
  def edit
    
  end
  
  
  def update
    
  end
  
  
  def delete
    
  end
  
  
  def destroy
    
  end
  
end