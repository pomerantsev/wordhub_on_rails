require 'spec_helper'

describe "repetitions/index.rabl" do
  let(:repetition) { create :repetition }
  it "renders a json representation of the repetition" do
    assign(:repetitions, [repetition])
    render
    rendered_repetition = JSON.parse(rendered)[0]
    expect(rendered_repetition['id']).to eq repetition.id
    expect(rendered_repetition['flashcard']['frontText'])
      .to eq repetition.flashcard.front_text
    expect(rendered_repetition['flashcard']['backText'])
      .to eq repetition.flashcard.back_text
  end
end
