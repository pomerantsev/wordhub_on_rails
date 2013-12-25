require 'spec_helper'

feature "Flashcard search" do
  before do
    user = create :user
    create :flashcard, user: user, front_text: "Yes front", back_text: "No"
    create :flashcard, user: user, front_text: "No front", back_text: "Yes"
    create :flashcard, user: user, front_text: "Yes front", back_text: "Yes"

    sign_in user
    visit flashcards_path
  end

  def search(search_string)
    fill_in "search", with: search_string
    click_button I18n.t("flashcards.index.search")
  end

  scenario "filters flashcards by both front_text and back_text" do
    search "Yes"
    expect(page).to have_content("front", count: 3)

    search "No"
    expect(page).to have_content("front", count: 2)

    search "Maybe"
    expect(page).to_not have_content("front")
  end

  scenario "shows the link to all flashcards when search is on" do
    expect(page).to_not have_link(I18n.t("flashcards.index.show_all"))

    search "Something"
    expect(page).to have_content("Something")
    expect(page).to have_link(I18n.t("flashcards.index.show_all"))
  end
end
