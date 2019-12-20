# frozen_string_literal: true

require "rails_helper"
describe "セッション機能", type: :system do
  describe "ログイン" do
    before do
      FactoryBot.create(:user, name: "usera", email: "user.1@hogehoge.com")
    end
    context "ログイン画面でユーザー情報を正しく入力し、ログインボタンを押すと" do
      before do
        visit welcome_path
        fill_in("email", with: "user.1@hogehoge.com")
        fill_in("password",   with: "secret")
        click_button "ログイン"
      end

      it "ログインが正しくできる" do
        expect(page).to have_content "ログアウト"
        expect(current_path).to eq root_path
      end
    end

    context "ログイン画面で誤ったユーザー情報を正しく入力し、ログインボタンを押すと" do
      before do
        visit welcome_path
        fill_in("email", with: "user.1@hogehoge.com")
        fill_in("password",   with: "seeecret")
        click_button "ログイン"
      end

      it "ログインできない" do
        expect(page).to have_content "メールアドレスかパスワードが違います。"
        expect(current_path).to eq login_path
      end
    end
  end
end
