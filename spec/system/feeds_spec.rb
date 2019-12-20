# frozen_string_literal: true

require "rails_helper"
describe "フィード機能", type: :system do
  let(:user_a) { FactoryBot.create(:user, name: "usera", email: "user.1@hogehoge.com") }
  let(:user_b) { FactoryBot.create(:user, name: "userb", email: "user.2@hogehoge.com") }
  let(:user_c) { FactoryBot.create(:user, name: "userc", email: "user.3@hogehoge.com") }
  let(:log_a) { FactoryBot.create(:log, title: "ログA", description: "ログAの説明文です。", user: user_a) }

  describe "ログ作成フィード" do
    before do
      FactoryBot.create(:follow_relationship, following: user_b, follower: user_a)
      FactoryBot.create(:follow_relationship, following: user_c, follower: user_b)
      FactoryBot.create(:log, title: "ユーザーAのログ", user: user_a)
    end

    context "フォローしているユーザーがログを作成すると" do
      before do
        login_user(user_b)
        visit root_path
      end

      it "ログを作成したフィードが表示される" do
        expect(page).to have_content "useraさんが「ユーザーAのログ」を作成しました。"
      end
    end

    context "フォローしていないユーザーがログを作成すると" do
      before do
        login_user(user_c)
        visit root_path
      end

      it "ログを作成したフィードが表示されない" do
        expect(page).to have_no_content "useraさんが「ユーザーAのログ」を作成しました。"
      end
    end
  end

  describe "ログ更新フィード" do
    before do
      FactoryBot.create(:follow_relationship, following: user_b, follower: user_a)
      FactoryBot.create(:follow_relationship, following: user_c, follower: user_b)
      FactoryBot.create(:value, value: 2.5, log: log_a)
    end

    context "フォローしているユーザーがログを更新すると" do
      before do
        login_user(user_b)
        visit root_path
      end

      it "ログを更新したフィードが表示される" do
        expect(page).to have_content "useraさんが「ログA」を更新しました。"
      end
    end

    context "フォローしていないユーザーがログを更新すると" do
      before do
        login_user(user_c)
        visit root_path
      end

      it "ログを更新したフィードが表示されない" do
        expect(page).to have_no_content "useraさんが「ユーザーAのログ」を更新しました。"
      end
    end
  end

  describe "被フォローフィード" do
    context "他のユーザーにフォローされると" do
      before do
        FactoryBot.create(:follow_relationship, following: user_b, follower: user_a)
        login_user(user_a)
        visit root_path
      end

      it "フォローされたフィードが追加される" do
        expect(page).to have_content "userbさんにフォローされました。"
      end
    end
  end

  describe "フォローしているユーザーのフォローフィード" do
    context "フォローしているユーザーが他のユーザーをフォローすると" do
      before do
        FactoryBot.create(:follow_relationship, following: user_c, follower: user_b)
        FactoryBot.create(:follow_relationship, following: user_b, follower: user_a)
        login_user(user_c)
        visit root_path
      end

      it "フォローしたフィードが追加される" do
        expect(page).to have_content "userbさんがuseraさんをフォローしました。"
      end
    end
  end
end
