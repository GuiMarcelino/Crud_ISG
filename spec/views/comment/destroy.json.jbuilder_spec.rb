require 'rails_helper'

RSpec.describe "comments/destroy", type: :view do
  let(:comment) { create(:comment) }

  it "renders a message confirming deletion" do
    assign(:comment, comment)
    render
    json_response = JSON.parse(rendered)
    expect(json_response['comment']['message']).to eq('Comment deleted successfully')
    expect(json_response['comment']['id']).to eq(comment.id)
  end
end
