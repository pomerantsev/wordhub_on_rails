FactoryGirl.define do
  factory :repetition do
    association :flashcard
    planned_date { Time.now.localtime.to_date + 1.day }
    actual_date { Time.now.localtime.to_date + 1.day }
  end
end
