# coding: UTF-8

require 'spec_helper'

feature "User pages" do
  scenario "signup" do
  	visit signup_path

    expect(page).to have_selector "h2", text: I18n.t("users.new.new_user")

    expect do
      click_button I18n.t("users.new.sign_up")
    end.to_not change(User, :count)

		fill_in "user_email", with: "email@example.foo.com"
		fill_in "user_password", with: "super_secret_password"

  	expect do
      click_button I18n.t("users.new.sign_up")
    end.to change(User, :count).by(1)
  end
end
