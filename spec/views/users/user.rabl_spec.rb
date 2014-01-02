require 'spec_helper'

describe "users/user.rabl" do
  let(:user) { create :user }
  it "renders a json representation of the user" do
    assign(:user, user)
    created_today = 0
    view.stub(:created_today_by).and_return(created_today)
    render
    rendered_user = JSON.parse(rendered)
    expect(rendered_user['id']).to eq user.id
    expect(rendered_user['name']).to eq user.name
    expect(rendered_user['email']).to eq user.email
    expect(rendered_user['dailyLimit']).to eq user.daily_limit
    expect(rendered_user['interfaceLanguage']).to eq user.interface_language.to_s
    expect(rendered_user['createdToday']).to eq created_today
  end

end
