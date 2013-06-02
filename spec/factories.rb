# coding: UTF-8

FactoryGirl.define do
	factory :user do
		name "Иван Иванов"
		email "ivan@example.com"
		password "secretpassword"
	end

	factory :flashcard do
    sequence(:front_text)  { |n| "Lorem ipsum #{n}" }
    sequence(:back_text) { |n| "Лорем ипсум #{n}" }   
  end
end