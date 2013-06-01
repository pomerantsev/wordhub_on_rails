# coding: UTF-8

require 'spec_helper'

describe "Static pages" do
  describe "Intro page" do
    it "should have the content 'Читайте интересные тексты'" do
      visit intro_path
      page.should have_content("Читайте интересные тексты")
    end
  end
end
