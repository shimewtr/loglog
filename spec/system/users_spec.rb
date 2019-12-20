# frozen_string_literal: true

require "rails_helper"
describe "ユーザー機能", type: :system do
  let(:user_a) { FactoryBot.create(:user, name: "usera", email: "user.1@hogehoge.com") }
  let(:user_b) { FactoryBot.create(:user, name: "userb", email: "user.2@hogehoge.com") }

  describe "ユーザー作成" do
    context "必要事項を入力して作成ボタンをクリックしたとき" do
      before do
        visit new_user_path
        fill_in "user_email", with: "test@email.com"
        fill_in "name", with: "user_name"
        fill_in "user_password", with: "aaaa"
        fill_in "user_password_confirmation", with: "aaaa"
        click_button "作成"
      end

      it "認証メールを送信したことが表示される" do
        expect(page).to have_content "認証メールを送信しました。受け取ったメールから認証を完了してください。"
      end
    end
  end

  describe "ユーザーページ" do
    context "ログインしていないユーザーがユーザーページに遷移したとき" do
      before do
        visit user_path(user_a)
      end

      it "ユーザーページが正しく表示される" do
        expect(page).to have_content "usera"
      end
    end

    context "ログインしているユーザーがユーザーページに遷移したとき" do
      before do
        login_user(user_b)
        visit user_path(user_a)
      end

      it "ユーザーページが正しく表示される" do
        expect(page).to have_content "usera"
      end
    end
  end

  describe "ユーザー情報編集UI" do
    context "自分のユーザーページに遷移したとき" do
      before do
        login_user(user_a)
        visit user_path(user_a)
      end

      it "ユーザー情報の編集UIが表示される" do
        expect(page).to have_content "編集"
      end
    end

    context "自分以外のユーザーページに遷移したとき" do
      before do
        login_user(user_a)
        visit user_path(user_b)
      end

      it "ユーザー情報の編集UIが表示されない" do
        expect(page).to have_no_content "編集"
      end
    end

    context "ログインしていないユーザーがユーザーページに遷移したとき" do
      before do
        visit user_path(user_b)
      end

      it "ユーザー情報の編集UIが表示されない" do
        expect(page).to have_no_content "編集"
      end
    end
  end

  describe "ユーザー情報更新" do
    context "ユーザー情報編集ページに情報に必要事項を入力してで更新ボタンを押すと" do
      before do
        login_user(user_a)
        visit edit_user_path(user_a)
        fill_in "user_email", with: "update_email@test.com"
        fill_in "name", with: "update_name"
        fill_in "user_description", with: "自己紹介を更新"
        click_button "更新"
      end
      it "ユーザー情報が更新される" do
        expect(page).to have_content  "ユーザー情報を更新しました。"
        expect(page).to have_content  "update_name"
        expect(page).to have_content  "自己紹介を更新"
      end
    end
  end

  describe "ユーザー削除UI" do
    context "自分のユーザーページに遷移したとき" do
      before do
        login_user(user_a)
        visit user_path(user_a)
      end

      it "ユーザー削除UIが表示される" do
        expect(page).to have_content "削除"
      end
    end

    context "自分以外のユーザーページに遷移したとき" do
      before do
        login_user(user_a)
        visit user_path(user_b)
      end

      it "ユーザー削除UIが表示されない" do
        expect(page).to have_no_content "削除"
      end
    end

    context "ログインしていないユーザーがユーザーページに遷移したとき" do
      before do
        visit user_path(user_b)
      end

      it "ユーザー削除の編集UIが表示されない" do
        expect(page).to have_no_content "削除"
      end
    end
  end

  describe "ユーザー削除" do
    context "ユーザー情報ページの削除ボタンを押すと" do
      before do
        login_user(user_a)
        visit user_path(user_a)
        accept_confirm do
          click_link "削除"
        end
      end
      it "ユーザーが削除される" do
        expect(page).to have_content "ユーザーを削除しました。"
      end
    end
  end
end
