# frozen_string_literal: true

require "rails_helper"
describe "User", type: :model do
  let(:user_a) { FactoryBot.create(:user, name: "usera", email: "user.1@hogehoge.com") }
  let(:user_b) { FactoryBot.create(:user, name: "userb", email: "user.2@hogehoge.com") }
  let(:user_c) { FactoryBot.create(:user, name: "userc", email: "user.3@hogehoge.com") }

  describe "followed_by?" do
    before do
      FactoryBot.create(:follow_relationship, following: user_a, follower: user_b)
      FactoryBot.create(:follow_relationship, following: user_b, follower: user_a)
    end

    context "フォローされているユーザーの場合" do
      it "trueを返す" do
        expect(user_b.followed_by?(user_a)).to be true
        expect(user_a.followed_by?(user_b)).to be true
      end
    end

    context "フォローされていないユーザーの場合" do
      it "falseを返す" do
        expect(user_c.followed_by?(user_a)).to be false
        expect(user_a.followed_by?(user_c)).to be false
      end
    end
  end

  describe "gravatar_url" do
    it "gravatarのURLを返す" do
      expect(user_a.gravatar_url).to eq "https://www.gravatar.com/avatar/b419b8dad0e602ef9a4455991238873e?r=g&d=mp"
      expect(user_b.gravatar_url).to eq "https://www.gravatar.com/avatar/90fdb6e6653f9e6e218252c50d9b7b85?r=g&d=mp"
    end
  end
end
