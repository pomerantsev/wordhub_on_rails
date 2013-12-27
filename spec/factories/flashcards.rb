# == Schema Information
#
# Table name: flashcards
#
#  id                                 :integer          not null, primary key
#  user_id                            :integer
#  front_text                         :text
#  back_text                          :text
#  consecutive_successful_repetitions :integer          default(0)
#  created_at                         :datetime         not null
#  updated_at                         :datetime         not null
#  deleted                            :boolean          default(FALSE)
#  learned_on                         :date
#


require 'faker'

FactoryGirl.define do

  factory :flashcard do
    association :user

    front_text { Faker::Lorem.paragraph }
    back_text { Faker::Lorem.word }

    factory :deleted_flashcard do
      deleted true
    end
  end
end
