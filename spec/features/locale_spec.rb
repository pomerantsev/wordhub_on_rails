require 'spec_helper'

feature "Locales" do
  context "when not logged in" do
    context "when tld is 'ru'" do
      scenario "it sets locale to :ru" do
        Capybara.app_host = "http://wordhub.ru"
        visit root_path
        expect(I18n.locale).to eq :ru
      end
    end

    context "when tld is 'com'" do
      scenario "it sets locale to :en" do
        Capybara.app_host = "http://wordhub.herokuapp.com"
        visit root_path
        expect(I18n.locale).to eq :en
      end
    end

    context "when tld is 'org'" do
      scenario "it sets locale to :en" do
        Capybara.app_host = "http://wordhub.org"
        visit root_path
        expect(I18n.locale).to eq :en
      end
    end
  end

  context "when logged in" do
    before { sign_in user }

    context "when user's interface language is :ru" do
      given(:user) { create :user, interface_language: :ru }
      scenario "it sets locale to :ru" do
        visit root_path
        expect(I18n.locale).to eq :ru
      end
    end

    context "when user's interface language is :en" do
      given(:user) { create :user, interface_language: :en }
      scenario "it sets locale to :en" do
        visit root_path
        expect(I18n.locale).to eq :en
      end
    end
  end
end