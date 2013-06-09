# coding: UTF-8

require 'faker'

FactoryGirl.define do
	factory :flashcard do
    front_text { Faker::Lorem.paragraph }
    back_text { Faker::Lorem.word }
  end
end