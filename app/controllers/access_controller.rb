# coding: UTF-8

class AccessController < ApplicationController
  
  def attempt_login
    authorized_user = User.authenticate params[:email], params[:password]
    if authorized_user
      session[:user_id] = authorized_user.id
      redirect_to :controller => "flashcards"
    else
      flash[:notice] = "Неверный логин / пароль."
      redirect_to :controller => "application"
    end
  end
  
  def logout
    session[:user_id] = nil
    redirect_to :controller => "application"
  end
  
end
