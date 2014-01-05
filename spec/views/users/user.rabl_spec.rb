require 'spec_helper'

describe "users/user.rabl" do
  let(:user) { create :user, daily_limit: 10 }
  it "renders a json representation of the user" do
    assign(:user, user)
    created_today = 0
    run_today = 1
    planned_for_today = 2
    view.stub(:created_today_by).and_return(created_today)
    view.stub(:run_today_by).and_return(run_today)
    view.stub(:planned_for_today_by).and_return(planned_for_today)
    render
    rendered_user = JSON.parse(rendered)
    expect(rendered_user['id']).to eq user.id
    expect(rendered_user['name']).to eq user.name
    expect(rendered_user['email']).to eq user.email
    expect(rendered_user['dailyLimit']).to eq user.daily_limit
    expect(rendered_user['interfaceLanguage']).to eq user.interface_language.to_s
    expect(rendered_user['createdToday']).to eq created_today
    expect(rendered_user['runToday']).to eq run_today
    expect(rendered_user['plannedForToday']).to eq planned_for_today
  end

end
