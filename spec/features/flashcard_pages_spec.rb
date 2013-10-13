# coding: UTF-8

require 'spec_helper'
require 'flashcards_helper'

include FlashcardsHelper

feature "Flashcards" do
	given(:user) { create(:user) }
	background do
    3.times { create(:flashcard, user: user) }
    sign_in user
	end
	
	scenario "visiting the index page" do
		visit flashcards_path
		user.flashcards.each do |flashcard|
			expect(page).to have_flashcard(flashcard)
		end
		expect(page).to_not have_deleted_flashcard
	end

	scenario "deleting and undeleting a flashcard without JS" do
		flashcard = user.flashcards.first
		visit edit_flashcard_path(flashcard)
		click_button I18n.t("flashcards.form.delete")
		expect(page).to have_deleted_flashcard(flashcard)
		check first_line(flashcard.front_text)
		click_button I18n.t("flashcards.index.undelete")
		expect(page).to have_flashcard(flashcard)
		expect(page).to_not have_deleted_flashcard(flashcard)
  end

  scenario "deleting and undeleting a flashcard with JS", js: true do
  	flashcard = user.flashcards.first
		visit edit_flashcard_path(flashcard)
		click_button I18n.t("flashcards.form.delete")
		click_link I18n.t("flashcards.index.show_just_deleted")
		expect(page).to have_selector("label", text: first_line(flashcard.front_text))
		expect(page).to have_xpath "//input[@value='#{ I18n.t 'flashcards.index.undelete' }' and @disabled]"
		check first_line(flashcard.front_text)
		click_button I18n.t("flashcards.index.undelete")
		expect(page).to have_flashcard(flashcard)
		expect(page).to_not have_deleted_flashcard(flashcard)
  end

end
