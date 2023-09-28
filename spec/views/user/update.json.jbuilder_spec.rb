require 'rails_helper'

RSpec.describe "users/update", type: :view do
  let(:user) { create(:user, name: 'User1', email: 'user1@example.com') }

  it "renders the correct JSON structure" do
    user.name = 'User Update'
    user.email = 'update_email@gmail.com'
    user.save!
    assign(:user, user)
    render

    json_response = JSON.parse(rendered)
    expect(json_response['id']).to eq(user.id)
    expect(json_response['name']).to eq('User Update')
    expect(json_response['email']).to eq('update_email@gmail.com')
  end
end
