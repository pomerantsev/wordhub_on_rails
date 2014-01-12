class UsersController < ApplicationController

  before_action :confirm_logged_in, except: [:index, :new, :create]

  def new
    if logged_in?
      redirect_to home_page
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params.merge(interface_language: I18n.locale))
    respond_to do |format|
      format.html do
        if @user.save
          session[:user_id] = @user.id
          redirect_to home_page
        else
          flash.now[:error] = errors(@user)
          render :new
        end
      end
      format.json do
        if @user.save
          session[:user_id] = @user.id
          response.status = :created
          render 'access/success'
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end
    end
  end

  def show
    if params[:id].nil?
      @user = current_user
    else
      @user = User.find_by(id: params[:id])
    end
    respond_to do |format|
      format.html do
        if @user == current_user
          @total_stats, @stats_for_month, @stats_for_today = user_stats(@user)
        else
          flash[:error] = I18n.t("flash.cannot_see_other_users_stats")
          redirect_to home_page
        end
      end
      format.json do
        if @user == current_user
          render 'users/user'
        else
          head :unauthorized
        end
      end
    end
  end

  def edit
    if params[:id].nil?
      @user = current_user
    else
      @user = User.find_by_id(params[:id])
      if @user != current_user
        flash[:error] = I18n.t("flash.cannot_edit_other_users_settings")
        redirect_to home_page
      end
    end
  end

  def update
    if params[:id].nil?
      @user = current_user
    else
      @user = User.find_by_id(params[:id])
      if @user != current_user
        flash[:error] = I18n.t("flash.cannot_edit_other_users_settings")
        redirect_to home_page
      end
    end
    if @user == current_user
      if @user.update_attributes(user_params)
        flash[:success] = I18n.t("flash.settings_saved")
        redirect_to edit_user_path
      else
        flash.now[:error] = errors(@user)
        render :edit
      end
    end
  end

private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :daily_limit, :interface_language)
  end
end
