# frozen_string_literal: true

require "rails_helper"
describe "FeedHelper" do
  let(:user_a) { FactoryBot.create(:user, name: "usera", email: "user.1@hogehoge.com") }
  let(:user_b) { FactoryBot.create(:user, name: "userb", email: "user.2@hogehoge.com") }
  let(:user_c) { FactoryBot.create(:user, name: "userc", email: "user.3@hogehoge.com") }
  let(:log_a) { FactoryBot.create(:log, title: "ログA", description: "ログAの説明文です。", user: user_a) }

  describe "feed_text" do
    context "ログを作成したフィードのとき" do
      before do
        @feed = FactoryBot.create(:feed, user: user_a, sender: user_b, log: log_a, action: "log_create")
      end

      it "作成者と作成したログを作成した旨を伝えるテキストを返す" do
        expect(helper.feed_text(@feed)).to eq "userbさんが「ログA」を作成しました。"
      end
    end

    context "ログを更新したフィードのとき" do
      before do
        @feed = FactoryBot.create(:feed, user: user_a, sender: user_b, log: log_a, action: "value_create")
      end

      it "作成者とログを更新した旨を伝えるテキストを返す" do
        expect(helper.feed_text(@feed)).to eq "userbさんが「ログA」を更新しました。"
      end
    end

    context "フォローされたフィードのとき" do
      before do
        @feed = FactoryBot.create(:feed, user: user_a, sender: user_b, followed: user_a, action: "user_followed")
      end

      it "フォローしたユーザーにフォローされた旨を伝えるテキストを返す" do
        expect(helper.feed_text(@feed)).to eq "userbさんにフォローされました。"
      end
    end

    context "フォローしているユーザーが他のユーザーをフォローしたフィードのとき" do
      before do
        @feed = FactoryBot.create(:feed, user: user_a, sender: user_b, followed: user_c, action: "following_follow")
      end

      it "フォローしたユーザーにフォローされた旨を伝えるテキストを返す" do
        expect(helper.feed_text(@feed)).to eq "userbさんがusercさんをフォローしました。"
      end
    end
  end

  describe "feed_link" do
    context "ログを作成したフィードのとき" do
      before do
        @feed = FactoryBot.create(:feed, user: user_a, sender: user_b, log: log_a, action: "log_create")
      end

      it "作成したログへのリンクを返す" do
        expect(helper.feed_link(@feed)).to eq log_path(log_a)
      end
    end

    context "ログを更新したフィードのとき" do
      before do
        @feed = FactoryBot.create(:feed, user: user_a, sender: user_b, log: log_a, action: "value_create")
      end

      it "更新したログへのリンクを返す" do
        expect(helper.feed_link(@feed)).to eq log_path(log_a)
      end
    end

    context "フォローされたフィードのとき" do
      before do
        @feed = FactoryBot.create(:feed, user: user_a, sender: user_b, followed: user_a, action: "user_followed")
      end

      it "フォローしたユーザーのリンクを返す" do
        expect(helper.feed_link(@feed)).to eq user_path(user_b)
      end
    end

    context "フォローしているユーザーが他のユーザーをフォローしたフィードのとき" do
      before do
        @feed = FactoryBot.create(:feed, user: user_a, sender: user_b, followed: user_c, action: "following_follow")
      end

      it "フォローされたユーザーのリンクを返す" do
        expect(helper.feed_link(@feed)).to eq user_path(user_c)
      end
    end
  end
end
