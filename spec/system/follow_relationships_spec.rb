# frozen_string_literal: true

require "rails_helper"
describe "ログフォロー機能", type: :system do
  let(:user_a) { FactoryBot.create(:user, name: "usera", email: "user.1@hogehoge.com") }
  let(:user_b) { FactoryBot.create(:user, name: "userb", email: "user.2@hogehoge.com") }

  describe "フォローUI表示" do
    context "他のユーザーのユーザーページに遷移すると" do
      before do
        login_user(user_b)
        visit user_path(user_a)
      end

      it "フォローボタンが表示される" do
        expect(page).to have_css ".user-profile-links__link--follow"
      end
    end

    context "自分のユーザーページに遷移すると" do
      before do
        login_user(user_a)
        visit user_path(user_a)
      end

      it "フォローボタンが表示されない" do
        expect(page).to have_no_css ".user-profile-links__link--follow"
      end
    end

    context "ログインしていないユーザーがユーザーページに遷移すると" do
      before do
        visit user_path(user_a)
      end

      it "フォローボタンが表示されない" do
        expect(page).to have_no_css ".user-profile-links__link--follow"
      end
    end
  end

  describe "ユーザーフォロー" do
    context "フォローボタンをクリックすると" do
      before do
        login_user(user_b)
        visit user_path(user_a)
        find(".user-profile-links__link--follow").click
        sleep(1)
      end

      it "ユーザーをフォローできる" do
        expect(user_a.followed_by?(user_b)).to be true
      end
    end
  end

  describe "フォロー解除UI表示" do
    context "フォローしているユーザーのユーザーページに遷移すると" do
      before do
        FactoryBot.create(:follow_relationship, following: user_b, follower: user_a)
        login_user(user_b)
        visit user_path(user_a)
      end

      it "フォロー解除ボタンが表示される" do
        expect(page).to have_css ".user-profile-links__link--unfollow"
      end
    end

    context "自分のユーザーページに遷移すると" do
      before do
        login_user(user_a)
        visit user_path(user_a)
      end

      it "フォロー解除ボタンが表示されない" do
        expect(page).to have_no_css ".user-profile-links__link--unfollow"
      end
    end

    context "ログインしていないユーザーがユーザーページに遷移すると" do
      before do
        visit user_path(user_a)
      end

      it "フォロー解除ボタンが表示されない" do
        expect(page).to have_no_css ".user-profile-links__link--unfollow"
      end
    end
  end

  describe "ユーザーフォロー解除" do
    context "フォロー解除ボタンをクリックすると" do
      before do
        FactoryBot.create(:follow_relationship, following: user_b, follower: user_a)
        login_user(user_b)
        visit user_path(user_a)
        find(".user-profile-links__link--unfollow").click
        sleep(1)
      end

      it "ユーザーをフォロー解除できる" do
        expect(user_a.followed_by?(user_b)).to be false
      end
    end
  end
end
