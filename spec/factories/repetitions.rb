FactoryGirl.define do
	factory :repetition do
		association :flashcard

		factory :repetition_run do
			run true
		end

		factory :repetition_planned_for_today do
			planned_date { Date.today }
			actual_date { Date.today }
		end

		factory :repetition_planned_for_tomorrow do
			planned_date { Date.tomorrow }
			actual_date { Date.tomorrow }
		end

	end
end