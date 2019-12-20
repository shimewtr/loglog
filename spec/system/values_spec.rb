# frozen_string_literal: true

require "rails_helper"
describe "バリュー機能", type: :system do
  let(:user_a) { FactoryBot.create(:user, name: "usera", email: "user.1@hogehoge.com") }
  let(:user_b) { FactoryBot.create(:user, name: "userb", email: "user.2@hogehoge.com") }

  let(:log_a) { FactoryBot.create(:log, title: "ログA", description: "ログAの説明文です。", user: user_a) }

  describe "バリュー表示" do
    context "ログページに遷移すると" do
      before do
        FactoryBot.create(:value, value: 2.5, valued_on: Date.today - 1, log: log_a)
        FactoryBot.create(:value, value: 3.4, log: log_a)
        visit log_path(log_a)
      end

      it "バリューが表示される" do
        expect(page).to have_content "2.5"
        expect(page).to have_content "3.4"
      end
    end
  end

  describe "バリュー作成UI表示" do
    context "自分が作成したログページに遷移すると" do
      before do
        login_user(user_a)
        visit log_path(log_a)
      end

      it "バリュー作成UIが表示される" do
        expect(page).to have_css ".value-form"
      end
    end

    context "自分が作成していないログページに遷移すると" do
      before do
        login_user(user_b)
        visit log_path(log_a)
      end

      it "バリュー作成UIが表示されない" do
        expect(page).to have_no_css ".value-form"
      end
    end

    context "ログインしていないユーザーがログページに遷移すると" do
      before do
        visit log_path(log_a)
      end

      it "バリュー作成UIが表示されない" do
        expect(page).to have_no_css ".value-form"
      end
    end
  end

  describe "バリュー作成" do
    context "バリュー追加フォームに必要事項を入力して追加ボタンを押すと" do
      before do
        login_user(user_a)
        visit log_path(log_a)
        fill_in "value", with: "5.0"
        fill_in "valued_on", with: Date.today
        click_button "追加"
      end

      it "バリューが追加される" do
        expect(page).to have_content "値を追加しました。"
        expect(page).to have_content "5.0"
      end
    end
  end

  describe "バリュー削除UI表示" do
    before do
      FactoryBot.create(:value, value: 2.5, valued_on: Date.today - 1, log: log_a)
      FactoryBot.create(:value, value: 3.4, log: log_a)
    end

    context "自分が作成したログページに遷移すると" do
      before do
        login_user(user_a)
        visit log_path(log_a)
      end

      it "バリュー削除UIが表示される" do
        expect(page).to have_css ".log-values-table__button"
      end
    end

    context "自分が作成していないログページに遷移すると" do
      before do
        login_user(user_b)
        visit log_path(log_a)
      end

      it "バリュー削除UIが表示されない" do
        expect(page).to have_no_css ".log-values-table__button"
      end
    end

    context "ログインしていないユーザーがログページに遷移すると" do
      before do
        visit log_path(log_a)
      end

      it "バリュー削除UIが表示されない" do
        expect(page).to have_no_css ".log-values-table__button"
      end
    end
  end

  describe "バリュー削除" do
    before do
      FactoryBot.create(:value, value: 2.5, valued_on: Date.today - 1, log: log_a)
      FactoryBot.create(:value, value: 3.4, log: log_a)
    end

    context "削除ボタンをおすと" do
      before do
        login_user(user_a)
        visit log_path(log_a)
        accept_confirm do
          first(".log-values-table__button").click
        end
      end

      it "バリューが削除される" do
        expect(page).to have_no_content "2.5"
      end
    end
  end
end
