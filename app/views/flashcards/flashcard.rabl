attributes :id, :deleted
attributes front_text: :frontText,
           back_text: :backText,
           consecutive_successful_repetitions: :consecutiveSuccessfulRepetitions,
           created_at: :createdAt
node(:isCreatedToday) { |f| f.created_today? }
node(:isLearned) { |f| f.learned? }
