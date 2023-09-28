require 'rails_helper'

RSpec.describe "posts/update", type: :view do
  let(:user) { create(:user, name: 'User1', email: 'user1@example.com') }
  let(:post) { create(:post, title: 'Title', text: 'Text1', user: user) }

  it "renders the correct JSON structure" do
    post.title = 'Updated Title'
    post.text = 'Updated Text'
    post.save!
    assign(:post, post)
    render

    json_response = JSON.parse(rendered)
    expect(json_response['id']).to eq(post.id)
    expect(json_response['title']).to eq('Updated Title')
    expect(json_response['text']).to eq('Updated Text')
    expect(json_response['updated_at']).not_to be_nil
  end
end
