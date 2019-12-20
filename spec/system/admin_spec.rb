# frozen_string_literal: true

require "rails_helper"
describe "アドミン機能", type: :system do
  let(:admin_user) { FactoryBot.create(:user, name: "admin", email: "admin@hogehoge.com", admin: true) }
  let(:user_a) { FactoryBot.create(:user, name: "usera", email: "user.a@hogehoge.com") }

  describe "アドミンユーザー一覧機能" do
    before do
      FactoryBot.create(:user, name: "user1", email: "user.1@loglog.me")
      FactoryBot.create(:user, name: "user2", email: "user.2@loglog.me")
      FactoryBot.create(:user, name: "user3", email: "user.3@loglog.me")
    end

    context "アドミンユーザーとしてログインすると" do
      before do
        login_user(admin_user)
        visit admin_users_path
      end

      it "ユーザー一覧を表示できる" do
        expect(page).to have_content "user1"
        expect(page).to have_content "user2"
        expect(page).to have_content "user3"
      end
    end

    context "アドミン以外のユーザーとしてログインすると" do
      before do
        login_user(user_a)
        visit admin_users_path
      end

      it "ユーザー一覧を表示できない" do
        expect(page).to have_no_content "user1"
        expect(page).to have_no_content "user2"
        expect(page).to have_no_content "user3"
      end
    end

    context "ログインしていないと" do
      before do
        visit admin_users_path
      end

      it "ユーザー一覧を表示できない" do
        expect(page).to have_no_content "user1"
        expect(page).to have_no_content "user2"
        expect(page).to have_no_content "user3"
      end
    end
  end
end
