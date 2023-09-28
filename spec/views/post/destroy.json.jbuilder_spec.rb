require 'rails_helper'

RSpec.describe "posts/destroy", type: :view do
  let(:post) { create(:post, title: 'Title', text: 'Text') }

  it "renders the correct JSON structure" do
    assign(:post, post)
    render

    json_response = JSON.parse(rendered)
    expect(json_response['post']['message']).to eq('Post deleted successfully')
    expect(json_response['post']['id']).to eq(post.id)
  end
end
