require 'spec_helper'

describe Flashcard do
	before :each do
		@user = User.create(
			email: "foo@bar.com",
			password: "secretpassword")
		@flashcard = @user.flashcards.build(
			front_text: "foo",
			back_text: "bar",
			deleted: false)
	end

	it "is valid with front text, back text, a user id and 'deleted' set to false" do
		expect(@flashcard).to be_valid
	end

	it "is invalid without front text" do
		@flashcard.front_text = nil
		expect(@flashcard).to have(1).errors_on(:front_text)
	end

	it "is invalid with blank front text" do
		# TODO: а как сделать, чтобы этот тест ломался?
		@flashcard.front_text = "   "
		expect(@flashcard).to have(1).errors_on(:front_text)
	end

	it "is invalid without back text" do
		@flashcard.back_text = nil
		expect(@flashcard).to have(1).errors_on(:back_text)
	end

	it "is invalid with blank back text" do
		@flashcard.back_text = "   "
		expect(@flashcard).to have(1).errors_on(:back_text)
	end

	it "is invalid without 'deleted' field specified" do
		@flashcard.deleted = nil
		expect(@flashcard).to have(1).errors_on(:deleted)
	end

	context "user" do
		it "is invalid without a user id" do
			@flashcard.user_id = nil
			expect(@flashcard).to have(1).errors_on(:user_id)
		end

		it "is invalid with non-existent user id" do
			@flashcard.user_id = 100
			expect(@flashcard).to have(1).errors_on(:user)
		end
	end

	context "'learned_on' date" do
		it "is valid without a 'learned_on' date" do
			@flashcard.learned_on = nil
			expect(@flashcard).to be_valid
		end

		it "is valid with 'learned_on' date set in the past" do
			@flashcard.learned_on = Date.today - 2.days
			expect(@flashcard).to be_valid
		end

		it "is valid with 'learned_on' date set today" do
			@flashcard.learned_on = Date.today
			expect(@flashcard).to be_valid
		end

		it "is invalid with 'learned_on' date set in the future" do
			@flashcard.learned_on = Date.today + 3.days
			expect(@flashcard).to have(1).errors_on(:learned_on)
		end
	end
end