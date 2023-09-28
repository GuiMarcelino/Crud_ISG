require 'rails_helper'

RSpec.describe "posts/show", type: :view do
  let(:user) { create(:user, name: 'User1', email: 'user1@example.com') }
  let(:post) { create(:post, title: 'Title', text: 'Text', user: user) }

  it "renders the correct JSON structure" do
    assign(:post, post)
    render

    json_response = JSON.parse(rendered)
    expect(json_response['id']).to eq(post.id)
    expect(json_response['title']).to eq('Title')
    expect(json_response['text']).to eq('Text')
  end
end
