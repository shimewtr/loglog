# frozen_string_literal: true

require "rails_helper"
describe "ログ機能", type: :system do
  let(:user_a) { FactoryBot.create(:user, name: "usera", email: "user.1@hogehoge.com") }
  let(:user_b) { FactoryBot.create(:user, name: "userb", email: "user.2@hogehoge.com") }
  let(:user_c) { FactoryBot.create(:user, name: "userc", email: "user.3@hogehoge.com") }
  let(:log_a) { FactoryBot.create(:log, title: "ログA", description: "ログAの説明文です。", user: user_a) }

  describe "一覧表示機能" do
    before do
      FactoryBot.create(:log, title: "ログA", description: "ログAの説明文です。", user: user_a)
      FactoryBot.create(:log, title: "ログB", description: "ログBの説明文です。", user: user_b)
      FactoryBot.create(:log, title: "ログC", description: "ログCの説明文です。", user: user_c)
      visit logs_path
    end

    context "ログインしていないユーザーがログ一覧画面に遷移すると" do
      it "作成済みのログが表示される" do
        expect(page).to have_content "ログA"
        expect(page).to have_content "ログB"
        expect(page).to have_content "ログC"
      end
    end

    context "ログインしているユーザーがログ一覧画面に遷移すると" do
      before do
        login_user(user_a)
      end

      it "作成済みのログが表示される" do
        expect(page).to have_content "ログA"
        expect(page).to have_content "ログB"
        expect(page).to have_content "ログC"
      end
    end
  end

  describe "ログ作成" do
    context "ログインしていないユーザーがログ作成画面に遷移すると" do
      before do
        visit new_log_path
      end

      it "ログイン画面に遷移する" do
        expect(page).to have_content "その操作はログインが必要です"
        expect(current_path).to eq welcome_path
      end
    end

    context "ログ作成画面に必要事項を入力して作成ボタンを押すと" do
      before do
        login_user(user_a)
        visit new_log_path
        fill_in "log_title", with: "作成するログのタイトル"
        fill_in "log_description", with: "作成するログの説明文"
        click_button "作成"
      end

      it "ログが作成される" do
        expect(page).to have_content "作成するログのタイトルを作成しました。"
      end
    end
  end

  describe "ログページ" do
    context "ログインしていないユーザーがログ詳細画面に遷移すると" do
      before do
        visit log_path(log_a)
      end

      it "ログの情報が表示される" do
        expect(page).to have_content "ログA"
        expect(page).to have_content "ログAの説明文です。"
      end
    end

    context "ログインしているユーザーがログ詳細画面に遷移すると" do
      before do
        login_user(user_a)
        visit log_path(log_a)
      end

      it "ログの情報が表示される" do
        expect(page).to have_content "ログA"
        expect(page).to have_content "ログAの説明文です。"
      end
    end
  end

  describe "ログ情報編集UI" do
    context "自分が作成したログページに遷移したとき" do
      before do
        login_user(user_a)
        visit log_path(log_a)
      end

      it "ログ情報の編集UIが表示される" do
        expect(page).to have_content "編集"
      end
    end

    context "自分が作成していないログページに遷移したとき" do
      before do
        login_user(user_b)
        visit log_path(log_a)
      end

      it "ログ情報の編集UIが表示されない" do
        expect(page).to have_no_content "編集"
      end
    end

    context "ログインしていないユーザーがユーザーページに遷移したとき" do
      before do
        visit log_path(log_a)
      end

      it "ログ情報の編集UIが表示されない" do
        expect(page).to have_no_content "編集"
      end
    end
  end

  describe "ログ情報編集ページ" do
    context "ログ作成者じゃないユーザーがログ情報編集画面に遷移すると" do
      before do
        login_user(user_b)
        visit edit_log_path(log_a)
      end

      it "ルートパスに遷移する" do
        expect(page).to have_content "このログの変更権限がありません。"
        expect(current_path).to eq root_path
      end
    end

    context "ログ作成者がログ情報編集画面に必要事項を入力して更新ボタンを押すと" do
      before do
        login_user(user_a)
        visit edit_log_path(log_a)
        fill_in "log_title", with: "更新後のログのタイトル"
        fill_in "log_description", with: "更新後のログの説明文"
        click_button "更新"
      end

      it "ログが更新される" do
        expect(page).to have_content "更新後のログのタイトルを更新しました。"
        expect(page).to have_content "更新後のログの説明文"
      end
    end
  end


  describe "ログ削除UI" do
    context "自分が作成したログページに遷移したとき" do
      before do
        login_user(user_a)
        visit log_path(log_a)
      end

      it "ログ削除UIが表示される" do
        expect(page).to have_content "削除"
      end
    end

    context "自分が作成していないログページに遷移したとき" do
      before do
        login_user(user_b)
        visit log_path(log_a)
      end

      it "ログ削除UIが表示されない" do
        expect(page).to have_no_content "削除"
      end
    end

    context "ログインしていないユーザーがユーザーページに遷移したとき" do
      before do
        visit log_path(log_a)
      end

      it "ログ削除UIが表示されない" do
        expect(page).to have_no_content "削除"
      end
    end
  end

  describe "ログ削除" do
    context "ログ削除ボタンをクリックすると" do
      before do
        login_user(user_a)
        visit log_path(log_a)
        accept_confirm do
          click_link "削除", match: :first
        end
      end

      it "ログが削除される" do
        expect(page).to have_content "ログAを削除しました。"
      end
    end
  end
end
