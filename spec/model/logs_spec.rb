# frozen_string_literal: true

require "rails_helper"
describe "Log", type: :model do
  let(:user_a) { FactoryBot.create(:user, name: "usera", email: "user.1@hogehoge.com") }
  let(:user_b) { FactoryBot.create(:user, name: "userb", email: "user.2@hogehoge.com") }
  let(:log_a) { FactoryBot.create(:log) }

  describe "followed_by?" do
    before do
      FactoryBot.create(:log_following, user: user_b, log: log_a)
    end

    context "フォローされているユーザーの場合" do
      it "trueを返す" do
        expect(log_a.followed_by?(user_b)).to be true
      end
    end

    context "フォローされていないユーザーの場合" do
      it "falseを返す" do
        expect(log_a.followed_by?(user_a)).to be false
      end
    end
  end
end
