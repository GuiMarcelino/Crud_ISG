require 'rails_helper'

RSpec.describe "posts/index", type: :view do
  let(:user) { create(:user, name: 'User1', email: 'user1@example.com') }
  let(:post) { create(:post, title: 'Title1', text: 'Text1', user: user) }
  let(:comment) { create(:comment, description: 'Teste', name: 'My Name', post: post) }

  before do
    comment
  end

  it "renders the correct JSON structure" do
    assign(:posts, [post])
    render

    json_response = JSON.parse(rendered)
    expect(json_response.count).to eq(1)
    expect(json_response[0]['id']).to eq(post.id)
    expect(json_response[0]['title']).to eq('Title1')
    expect(json_response[0]['text']).to eq('Text1')
    expect(json_response[0]['user']['name']).to eq('User1')
    expect(json_response[0]['user']['email']).to eq('user1@example.com')
    expect(json_response[0]['comments'][0]['description']).to eq('Teste')
    expect(json_response[0]['comments'][0]['name']).to eq('My Name')
  end
end
