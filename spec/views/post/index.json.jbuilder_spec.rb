require 'rails_helper'

RSpec.describe "posts/index", type: :view do
  let(:user) { create(:user, name: 'User1', email: 'user1@example.com') }
  let(:post1) { create(:post, title: 'Title1', text: 'Text1', user: user) }
  let(:post2) { create(:post, title: 'Title2', text: 'Text2', user: user) }

  it "renders the correct JSON structure" do
    assign(:posts, [post1, post2])
    render

    json_response = JSON.parse(rendered)
    expect(json_response.count).to eq(2)
    expect(json_response[0]['id']).to eq(post1.id)
    expect(json_response[0]['title']).to eq('Title1')
    expect(json_response[0]['text']).to eq('Text1')
  end
end
