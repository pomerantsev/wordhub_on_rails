# coding: UTF-8

def sign_in(user)
	visit root_path
	@password = user.password
  user.save
	fill_in "email", with: user.email
	fill_in "password", with: @password
	click_button "Войти"
end