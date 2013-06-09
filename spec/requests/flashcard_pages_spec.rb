# coding: UTF-8

require 'spec_helper'
require 'flashcards_helper'

include FlashcardsHelper

describe "Flashcards" do
  describe "Index page" do

  	subject { page }

    specify "for a non-signed in user" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get flashcards_path
      response.status.should be(302)
    end

    describe "for a signed-in user" do
    	before do
				user = User.new(FactoryGirl.attributes_for(:user))
	      sign_in user
	      @flashcards = []
	      3.times { @flashcards << user.flashcards.create(FactoryGirl.attributes_for(:flashcard)) }
	      visit flashcards_path
			end

			it "should contain all flashcards" do
				@flashcards.each do |flashcard|
					page.should have_link flashcard.front_text, href: edit_flashcard_path(flashcard)
				end
			end

			it { should_not have_link "Показать удалённые карточки" }

			describe "deleted flashcards" do
				before do
					visit edit_flashcard_path(@flashcards[0])
					click_button "Удалить"
					click_link "Показать удалённые карточки"
				end
				
				it { should have_selector("label", text: first_line(@flashcards[0].front_text)) }
				# Раньше xpath записывался как "//input[@value='Восстановить' and @disabled]", но с @disabled тест почему-то теперь не проходит.
				it { should have_xpath "//input[@value='Восстановить']" }

				describe "undeleting" do
					before do
						check first_line(@flashcards[0].front_text)
						click_button "Восстановить"
					end

					it { should have_link @flashcards[0].front_text, href: edit_flashcard_path(@flashcards[0]) }
					it { should_not have_button "Восстановить" }
				end
			end
    end
  end
end