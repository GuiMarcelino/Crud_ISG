require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:comments) }
  end

  describe "validations" do
    context "presence" do
      it { is_expected.to validate_presence_of(:title) }
      it { is_expected.to validate_presence_of(:text) }
    end
  end
end
