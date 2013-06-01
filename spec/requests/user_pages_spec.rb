# coding: UTF-8

require 'spec_helper'

describe "User pages" do

	subject { page }

  describe "signup page" do
    before { visit signup_path }

    it { should have_selector "h2", text: "Регистрация" }
  end

  describe "signup" do
  	before { visit signup_path }

  	let(:submit) { "Зарегистрироваться" }

  	describe "with invalid information" do
  		it "should not create a user" do
  			expect { click_button submit }.not_to change(User, :count)
  		end
  	end

  	describe "with valid information" do
  		before do
  			fill_in "user_email", with: "email@example.foo.com"
  			fill_in "user_password", with: "super_secret_password"
  		end

  		it "should create a user" do
  			expect { click_button submit }.to change(User, :count).by 1
  		end
  	end
  end
end
