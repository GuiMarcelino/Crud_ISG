require 'rails_helper'

RSpec.describe "comments/update", type: :view do
  let(:user) { create(:user, name: 'User1', email: 'user1@example.com') }
  let(:post) { create(:post, title: 'Title1', text: 'Text1', user: user) }
  let(:comment) { create(:comment, description: 'Teste', name: 'My Name', post: post) }



  it "renders the updated JSON structure for comment" do
    comment.description = 'Updated Teste'
    comment.save!
    assign(:comment, comment.reload)
    render

    json_response = JSON.parse(rendered)
    expect(json_response['id']).to eq(comment.id)
    expect(json_response['description']).to eq('Updated Teste')
  end
end
