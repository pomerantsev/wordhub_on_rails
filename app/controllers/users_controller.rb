# coding: UTF-8

class UsersController < ApplicationController

	before_filter :confirm_logged_in, except: [:new, :create]

	def new
		@user = User.new
	end

	def create
		@user = User.new(params[:user])
		if @user.save
			session[:user_id] = @user.id
			redirect_to flashcards_path
		else
			flash.now[:error] = errors(@user)
			render :new
		end
	end

	def show
		@total_stats = current_user.total_stats
		@stats_for_today = current_user.stats_for_period(1.day)
		@stats_for_last_month = current_user.stats_for_period(30.days)
	end

	def edit
		@user = current_user
	end

	def update
		@user = User.find_by_id(params[:id])
		if @user != current_user
			flash[:error] = "Вы пытаетесь изменить настройки для чужой учётной записи."
			redirect_to edit_user_path
		else
			if @user.update_attributes(params[:user])
				flash[:success] = "Настройки сохранены."
				redirect_to edit_user_path
			else
				flash.now[:error] = errors(@user)
				render :edit
			end
		end
	end
end
