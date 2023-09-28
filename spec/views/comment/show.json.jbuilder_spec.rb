require 'rails_helper'

RSpec.describe "posts/show", type: :view do
  let(:user) { create(:user, name: 'User1', email: 'user1@example.com') }
  let(:post) { create(:post, title: 'Title1', text: 'Text1', user: user) }
  let(:comment) { create(:comment, description: 'Teste', name: 'My Name', post: post) }

  before do
    comment
  end

  it "renders the correct JSON structure" do
    assign(:post, post)
    render

    json_response = JSON.parse(rendered)
    expect(json_response['id']).to eq(post.id)
    expect(json_response['title']).to eq('Title1')
    expect(json_response['text']).to eq('Text1')
    expect(json_response['user']['name']).to eq('User1')
    expect(json_response['user']['email']).to eq('user1@example.com')
    expect(json_response['comments'][0]['description']).to eq('Teste')
    expect(json_response['comments'][0]['name']).to eq('My Name')
  end
end
