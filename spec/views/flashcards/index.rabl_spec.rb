require 'spec_helper'

describe "flashcards/index.rabl" do
  let(:flashcard) { create :flashcard }
  it "renders a json representation of flashcards" do
    assign(:flashcards, [flashcard])
    render
    rendered_flashcard = JSON.parse(rendered)[0]
    expect(rendered_flashcard['id']).to eq flashcard.id
    expect(rendered_flashcard['deleted']).to eq flashcard.deleted
    expect(rendered_flashcard['frontText']).to eq flashcard.front_text
    expect(rendered_flashcard['backText']).to eq flashcard.back_text
    expect(rendered_flashcard['consecutiveSuccessfulRepetitions'])
      .to eq flashcard.consecutive_successful_repetitions
    expect(Time.zone.parse(rendered_flashcard['createdAt']).to_s)
      .to eq flashcard.created_at.to_s
  end

end
