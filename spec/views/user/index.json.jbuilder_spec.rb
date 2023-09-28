require 'rails_helper'

RSpec.describe "users/index", type: :view do
  let(:user1) { create(:user, name: 'User1', email: 'user1@example.com') }
  let(:user2) { create(:user, name: 'User2', email: 'user2@example.com') }
  it "renders the correct JSON structure" do
    assign(:users, [user1, user2])
    render

    json_response = JSON.parse(rendered)
    expect(json_response.count).to eq(2)
    expect(json_response[0]['id']).to eq(user1.id)
    expect(json_response[0]['name']).to eq('User1')
    expect(json_response[0]['email']).to eq('user1@example.com')
  end
end
