require 'spec_helper'
require 'shared_examples'

describe RepetitionsController do
	let(:user) { create(:user) }
	let(:first_flashcard) { create(:flashcard, user: user) }
	let(:second_flashcard) { create(:flashcard, user: user) }
	let(:third_flashcard) { create(:flashcard, user: user) }
	let!(:first_repetition_planned_for_today) { create(:repetition_planned_for_today, flashcard: first_flashcard) }
	let!(:second_repetition_planned_for_today) { create(:repetition_planned_for_today, flashcard: second_flashcard) }
	let!(:repetition_planned_for_tomorrow) { create(:repetition_planned_for_tomorrow, flashcard: third_flashcard) }

	describe "guest access" do
		describe "GET #index" do
			before(:each) { get :index }
			it_behaves_like "restricted pages"
		end

		describe "PUT #update" do
			before(:each) { put :update, id: first_repetition_planned_for_today, successful: true }
			it_behaves_like "restricted pages"
		end
	end

	describe "user access" do
		before(:each) { login user }

		describe "GET #index" do
			context "when there are no repetitions for today" do
				it "redirects to the #stats action" do
					first_repetition_planned_for_today.update_attribute(:actual_date, Date.tomorrow)
					second_repetition_planned_for_today.update_attribute(:actual_date, Date.tomorrow)
					get :index
					expect(response).to redirect_to stats_url
				end
			end

			context "when there are some repetitions for today" do
				it "populates the @repetitions array" do
					get :index
					expect(assigns(:repetitions)).to match_array [
						first_repetition_planned_for_today,
						second_repetition_planned_for_today]
				end

				context "when a valid repetition id is supplied" do
					it "assigns the @current_repetition variable" do
						get :index, repetition_id: first_repetition_planned_for_today
						expect(assigns(:current_repetition)).to eq first_repetition_planned_for_today
					end
				end

				context "when an invalid repetition id is supplied" do
					it "assigns a randomly selected value to the @current_repetition variable" do
						get :index, repetition_id: first_repetition_planned_for_today.id + 100
						expect([first_repetition_planned_for_today, second_repetition_planned_for_today]).
							to include assigns(:current_repetition)
					end
				end

				context "when a repetition id is not supplied" do
					it "assigns a randomly selected value to the @current_repetition variable" do
						get :index
						expect([first_repetition_planned_for_today, second_repetition_planned_for_today]).
							to include assigns(:current_repetition)
					end
				end

				it "sets the current_text and current_view variables" do
					get :index
					expect(assigns(:current_text)).to_not be_empty
					expect(assigns(:current_view)).to eq "front"
				end

				it "renders the :index view" do
					get :index
					expect(response).to render_template :index
				end
			end
		end

		describe "PUT #update" do
			context "for a repetition that should be run today" do
				context "with a valid :successful attribute" do
					it "updates the requested repetition" do
						put :update, id: first_repetition_planned_for_today, successful: true
						first_repetition_planned_for_today.reload
						expect(first_repetition_planned_for_today.successful).to be_true
						expect(first_repetition_planned_for_today.run).to be_true
					end

					it "creates another repetition" do
						expect do
							put :update, id: first_repetition_planned_for_today, successful: true
						end.to change(Repetition, :count).by(1)
					end

					it "redirects to the #index action" do
						put :update, id: first_repetition_planned_for_today, successful: true
						expect(response).to redirect_to repetitions_url
					end
				end

				context "without a :successful attribute" do
					it "does not update the requested repetition" do
						put :update, id: first_repetition_planned_for_today
						expect(first_repetition_planned_for_today.successful).to be_nil
						expect(first_repetition_planned_for_today.run).to be_false
					end

					it "does not create another repetition" do
						expect do
							put :update, id: first_repetition_planned_for_today
						end.to_not change(Repetition, :count)
					end

					it "sets a flash[:error] message" do
						put :update, id: first_repetition_planned_for_today
						expect(flash.to_hash).to_not eq({ })
					end

					it "redirects to the #index action" do
						put :update, id: first_repetition_planned_for_today
						expect(response).to redirect_to repetitions_url
					end
				end
			end

			context "for a repetition that should not be run today" do
				it "does not update the requested repetition" do
					put :update, id: repetition_planned_for_tomorrow, successful: true
					expect(repetition_planned_for_tomorrow.successful).to be_nil
					expect(repetition_planned_for_tomorrow.run).to be_false
				end

				it "does not create another repetition" do
					expect do
						put :update, id: repetition_planned_for_tomorrow, successful: true
					end.to_not change(Repetition, :count)
				end

				it "redirects to the #index action" do
					put :update, id: repetition_planned_for_tomorrow, successful: true
					expect(response).to redirect_to repetitions_url
				end
			end
		end
	end
end