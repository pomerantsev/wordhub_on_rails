require 'spec_helper'

feature "Locales" do
  after { Capybara.app_host = nil }

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

  context "when signing up" do
    before do
      Capybara.app_host = custom_host
      visit signup_path
      fill_in "user_email", with: "email@example.foo.com"
      fill_in "user_password", with: "super_secret_password"
      click_button "Зарегистрироваться"
    end

    context "when tld is 'ru'" do
      given(:custom_host) { "http://wordhub.ru" }
      scenario "it sets user's locale to :ru" do
        expect(User.last.interface_language).to eq :ru
      end
    end

    context "when tld is 'com'" do
      given(:custom_host) { "http://wordhub.com" }
      scenario "it sets user's locale to :en" do
        expect(User.last.interface_language).to eq :en
      end
    end
  end
end