class AccessController < ApplicationController

  def attempt_login
    authorized_user = User.authenticate params[:email].downcase, params[:password]
    session[:user_id] = authorized_user.id if authorized_user
    respond_to do |format|
      format.html do
        if authorized_user
          redirect_to new_flashcard_path
        else
          flash[:error] = I18n.t("flash.user_not_registered")
          redirect_to root_url
        end
      end
      format.json do
        if authorized_user
          render status: :ok,
            json: {
              success: true,
              user: authorized_user
            }
        else
          render status: :ok,
            json: {
              success: false
            }
        end
      end
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to root_url
  end

end
