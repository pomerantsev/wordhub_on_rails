require 'spec_helper'

describe "Flashcards" do
  describe "Index page" do
    it "for a non-signed in user" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get flashcards_path
      response.status.should be(302)
    end
  end
end
