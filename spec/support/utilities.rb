def sign_in(user)
  visit root_path
  fill_in "email", with: user.email
  fill_in "password", with: user.password
  click_button I18n.t("application.index.login_form.login")
end
