FactoryGirl.define do
  factory :repetition do
    association :flashcard
    planned_date { Date.tomorrow }
    actual_date { Date.tomorrow }
  end
end
