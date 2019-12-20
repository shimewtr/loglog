# frozen_string_literal: true

require "rails_helper"
describe "ログフォロー機能", type: :system do
  let(:user_a) { FactoryBot.create(:user, name: "usera", email: "user.1@hogehoge.com") }
  let(:user_b) { FactoryBot.create(:user, name: "userb", email: "user.2@hogehoge.com") }
  let(:user_c) { FactoryBot.create(:user, name: "userc", email: "user.c@hogehoge.com") }
  let(:log_a) { FactoryBot.create(:log, user: user_a) }

  describe "ログフォローUI表示" do
    context "他の人が作成したログのページに遷移すると" do
      before do
        login_user(user_b)
        visit log_path(log_a)
      end

      it "フォローボタンが表示される" do
        expect(page).to have_css ".log-header__link--follow"
      end
    end

    context "自分が作成したログのページに遷移すると" do
      before do
        login_user(user_a)
        visit log_path(log_a)
      end

      it "フォローボタンが表示されない" do
        expect(page).to have_no_css ".log-header__link--follow"
      end
    end

    context "ログインしていないユーザーがログのページに遷移すると" do
      before do
        visit log_path(log_a)
      end

      it "フォローボタンが表示されない" do
        expect(page).to have_no_css ".log-header__link--follow"
      end
    end
  end

  describe "ログフォロー" do
    context "フォローボタンをクリックすると" do
      before do
        login_user(user_b)
        visit log_path(log_a)
        find(".log-header__link--follow").click
        sleep(1)
      end

      it "ログをフォローできる" do
        expect(log_a.followed_by?(user_b)).to be true
      end
    end
  end

  describe "ログフォロー解除UI表示" do
    before do
      FactoryBot.create(:log_following, user: user_b, log: log_a)
    end

    context "フォローしているログのページに遷移すると" do
      before do
        login_user(user_b)
        visit log_path(log_a)
      end

      it "フォロー解除ボタンが表示される" do
        expect(page).to have_css ".log-header__link--unfollow"
      end
    end

    context "フォローしていないログのページに遷移すると" do
      before do
        login_user(user_c)
        visit log_path(log_a)
      end

      it "フォロー解除ボタンが表示されない" do
        expect(page).to have_no_css ".log-header__link--unfollow"
      end
    end

    context "自分が作成したログのページに遷移すると" do
      before do
        login_user(user_a)
        visit log_path(log_a)
      end

      it "フォロー解除ボタンが表示されない" do
        expect(page).to have_no_css ".log-header__link--unfollow"
      end
    end

    context "ログインしていないユーザーがログのページに遷移すると" do
      before do
        visit log_path(log_a)
      end

      it "フォロー解除ボタンが表示されない" do
        expect(page).to have_no_css ".log-header__link--unfollow"
      end
    end
  end

  describe "ログフォロー解除" do
    before do
      FactoryBot.create(:log_following, user: user_b, log: log_a)
    end

    context "フォロー解除ボタンをクリックすると" do
      before do
        login_user(user_b)
        visit log_path(log_a)
        find(".log-header__link--unfollow").click
        sleep(1)
      end

      it "ログをフォロー解除できる" do
        expect(log_a.followed_by?(user_b)).to be false
      end
    end
  end
end
