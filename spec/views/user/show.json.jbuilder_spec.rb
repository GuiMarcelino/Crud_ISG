require 'rails_helper'

RSpec.describe "users/show", type: :view do
  let(:user) { create(:user, name: 'User1', email: 'user1@example.com') }

  it "renders the correct JSON structure" do
    assign(:user, user)
    render

    json_response = JSON.parse(rendered)
    expect(json_response['id']).to eq(user.id)
    expect(json_response['name']).to eq('User1')
    expect(json_response['email']).to eq('user1@example.com')
  end
end
