class AccessController < ApplicationController

  def attempt_login
    @user = User.authenticate params[:email].downcase, params[:password]
    session[:user_id] = @user.id if @user
    respond_to do |format|
      format.html do
        if @user
          redirect_to new_flashcard_path
        else
          flash[:error] = I18n.t("flash.user_not_registered")
          redirect_to root_url
        end
      end
      format.json do
        response.status = :ok
        if @user
          render 'access/success'
        else
          render 'access/failure'
        end
      end
    end
  end

  def logout
    session[:user_id] = nil
    respond_to do |format|
      format.html { redirect_to root_url }
      format.json { head :no_content }
    end
  end

end
