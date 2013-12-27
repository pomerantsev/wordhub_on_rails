require 'spec_helper'

feature "Static pages" do
  scenario "visiting the intro page" do
    visit intro_path
    expect(page).to have_content(I18n.t("static_pages.intro.li_read_link_text"))
  end
end
