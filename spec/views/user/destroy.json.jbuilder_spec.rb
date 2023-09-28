require 'rails_helper'

RSpec.describe "users/destroy", type: :view do
  let(:user) { create(:user, name: 'User1', email: 'user1@example.com') }

  it "renders the correct JSON structure" do
    assign(:user, user)
    render

    json_response = JSON.parse(rendered)
    expect(json_response['user']['message']).to eq('User deleted successfully')
    expect(json_response['user']['id']).to eq(user.id)
  end
end
