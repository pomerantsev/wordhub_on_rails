# coding: UTF-8

require 'spec_helper'
require 'flashcards_helper'

include FlashcardsHelper

feature "Flashcards" do
	given(:user) { create(:user) }
	background do
    3.times { user.flashcards.create(attributes_for(:flashcard)) }
    sign_in user
	end
	
	scenario "visiting the index page" do
		visit flashcards_path
		user.flashcards.each do |flashcard|
			expect(page).to have_link flashcard.front_text, href: edit_flashcard_path(flashcard)
		end

		expect(page).to_not have_link "Показать удалённые карточки"
	end

	scenario "deleting and undeleting a flashcard without JS" do
		flashcard = user.flashcards.first
		visit edit_flashcard_path(flashcard)
		click_button "Удалить"
			
		expect(page).to have_selector("label", text: first_line(flashcard.front_text))
		# Раньше xpath записывался как "//input[@value='Восстановить' and @disabled]", но с @disabled тест будет работать только при включённом JS.
		expect(page).to have_xpath "//input[@value='Восстановить']"

		check first_line(flashcard.front_text)
		click_button "Восстановить"

		expect(page).to have_link flashcard.front_text, href: edit_flashcard_path(flashcard)
		expect(page).to_not have_button "Восстановить"
  end

  scenario "deleting and undeleting a flashcard with JS", js: true do
  	flashcard = user.flashcards.first
		visit edit_flashcard_path(flashcard)
		click_button "Удалить"
		click_link "Показать удалённые карточки"
			
		expect(page).to have_selector("label", text: first_line(flashcard.front_text))
		expect(page).to have_xpath "//input[@value='Восстановить' and @disabled]"

		check first_line(flashcard.front_text)
		click_button "Восстановить"

		expect(page).to have_link flashcard.front_text, href: edit_flashcard_path(flashcard)
		expect(page).to_not have_button "Восстановить"
  end

end