attributes :id
child(:flashcard) do
  attributes front_text: :frontText,
             back_text: :backText
end
