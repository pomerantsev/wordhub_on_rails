# coding: UTF-8

require "spec_helper"

feature "Signin" do

	scenario "with invalid information" do
		visit root_path
		click_button "Войти"
		expect(page).to have_selector "div.alert.alert-error"
	end

	scenario "with valid information" do
		user = create(:user)
    sign_in user
		expect(page).to have_content "Все карточки"
	end

end