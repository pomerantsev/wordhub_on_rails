# coding: UTF-8

require "spec_helper"

describe "Authentication" do
	
	subject { page }

	describe "signin" do
		before { visit root_path }

		describe "with invalid information" do
			before { click_button "Войти" }
			it { should have_selector "div.alert.alert-error" }
		end

		describe "with valid information" do
			before do
				# Привычнее было бы создать через let(:user) { FactoryGirl.create :user } ,
				# но тогда почему-то объект не записывается в базу;
				# возможно, ещё была бы проблема с паролем:
				# так как он удаляется при сохранении записи, его нельзя было бы получить для логина.
				user = User.new(FactoryGirl.attributes_for(:user))
	      sign_in user
			end

			it { should have_content "Все карточки" }

		end
	end

end