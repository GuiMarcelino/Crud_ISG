require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { build(:user) }

  describe "associations" do
    it { is_expected.to have_many(:posts) }
  end

  describe "validations" do
    context "presence" do
      it { is_expected.to validate_presence_of(:email) }
      it { is_expected.to validate_presence_of(:name) }
      it { is_expected.to validate_presence_of(:password_digest) }
    end

    context "uniqueness" do
      it { is_expected.to validate_uniqueness_of(:email) }
    end
  end
end
