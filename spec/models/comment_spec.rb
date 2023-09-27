require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:post) }
  end

  describe "validations" do
    context "presence" do
      it { is_expected.to validate_presence_of(:comment) }
      it { is_expected.to validate_presence_of(:name) }
    end
  end
end
