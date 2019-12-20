# frozen_string_literal: true

require "rails_helper"
describe "ホーム画面機能", type: :system do
  let(:user_a) { FactoryBot.create(:user, name: "usera", email: "user.1@hogehoge.com") }
  let(:user_b) { FactoryBot.create(:user, name: "userb", email: "user.2@hogehoge.com") }
  let(:admin_user) { FactoryBot.create(:user, name: "admin", email: "admin@hogehoge.com", admin: true) }

  describe "サービス紹介表示" do
    context "ログインしていないユーザーがroot_pathに遷移すると" do
      before do
        visit root_path
      end

      it "サービス紹介が表示される" do
        expect(page).to have_content "LogLogとは日々のちょっとした変化を残せるWebサービスです。"
      end
    end

    context "ログインしているユーザーがroot_pathに遷移すると" do
      before do
        login_user(user_a)
        visit root_path
      end

      it "サービス紹介が表示されない" do
        expect(page).to have_no_content "LogLogとは日々のちょっとした変化を残せるWebサービスです。"
      end
    end
  end

  describe "新着情報表示" do
    context "ログインしているユーザーがroot_pathに遷移すると" do
      before do
        login_user(user_a)
        visit root_path
      end

      it "新着情報が表示される" do
        expect(page).to have_content "新着情報"
      end
    end

    context "ログインしていないユーザーがroot_pathに遷移すると" do
      before do
        visit root_path
      end

      it "新着情報が表示されない" do
        expect(page).to have_no_content "新着情報"
      end
    end
  end

  describe "フォローログ表示" do
    context "ログインしているユーザーがroot_pathに遷移すると" do
      before do
        login_user(user_a)
        visit root_path
      end

      it "フォローしているが表示される" do
        expect(page).to have_content "フォローしているログ"
      end
    end

    context "ログインしていないユーザーがroot_pathに遷移すると" do
      before do
        visit root_path
      end

      it "フォローしているが表示されない" do
        expect(page).to have_no_content "フォローしているログ"
      end
    end
  end

  describe "アドミンメニュー機能" do
    context "アドミンユーザーとしてログインすると" do
      before do
        login_user(admin_user)
        visit root_path
      end

      it "アドミンメニューが表示される" do
        expect(page).to have_content "ユーザー一覧"
      end
    end

    context "アドミン以外のユーザーとしてログインすると" do
      before do
        login_user(user_a)
        visit root_path
      end

      it "アドミンメニューが表示されない" do
        expect(page).to have_no_content "ユーザー一覧"
      end
    end

    context "ログインしていないと" do
      before do
        visit root_path
      end

      it "アドミンメニューが表示されない" do
        expect(page).to have_no_content "ユーザー一覧"
      end
    end
  end
end
