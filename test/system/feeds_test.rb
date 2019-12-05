# frozen_string_literal: true

require "application_system_test_case"

class FeedsTest < ApplicationSystemTestCase
  test "フォローしているユーザーがログを作成したときフィードが追加されるか" do
    login_user("loglog.user.3@gmail.com", "aaaa")
    visit new_log_path
    fill_in "log_title", with: "作成するログのタイトル"
    fill_in "log_description", with: "作成するログの説明文"
    click_button "作成"

    login_user("loglog.user.1@gmail.com", "aaaa")
    visit root_path
    assert_text "Brunoさんが「作成するログのタイトル」を作成しました。"
  end

  test "フォローしているユーザーがログを更新したときフィードが追加されるか" do
    login_user("loglog.user.3@gmail.com", "aaaa")
    visit log_path(logs(:log_3))
    fill_in "value", with: "5.0"
    fill_in "valued_on", with: Date.current
    click_button "追加"

    login_user("loglog.user.1@gmail.com", "aaaa")
    visit root_path
    assert_text "Brunoさんが「ログのタイトル3」を更新しました。"
  end

  test "フォローしてないユーザーがログを作成したときフィードが追加されないか" do
    login_user("loglog.user.3@gmail.com", "aaaa")
    visit new_log_path
    fill_in "log_title", with: "作成するログのタイトル"
    fill_in "log_description", with: "作成するログの説明文"
    click_button "作成"

    login_user("loglog.user.2@gmail.com", "aaaa")
    visit root_path
    assert_no_text "Brunoさんが「作成するログのタイトル」を作成しました。"
  end

  test "フォローしてないユーザーがログを更新したときフィードが追加されないか" do
    login_user("loglog.user.3@gmail.com", "aaaa")
    visit log_path(logs(:log_3))
    fill_in "value", with: "5.0"
    fill_in "valued_on", with: Date.current
    click_button "追加"

    login_user("loglog.user.2@gmail.com", "aaaa")
    visit root_path
    assert_no_text "Brunoさんが「ログのタイトル3」を更新しました。"
  end

  test "ログが削除されたとき関連するフィードが削除されるか" do
    login_user("loglog.user.3@gmail.com", "aaaa")
    visit log_path(logs(:log_3))
    fill_in "value", with: "5.0"
    click_button "追加"
    sleep 3
    accept_confirm do
      click_link "削除", match: :first
    end

    login_user("loglog.user.1@gmail.com", "aaaa")
    visit root_path
    assert_no_text "Brunoさんが「ログのタイトル3」を更新しました。"
  end

  test "ユーザーが削除されたとき関連するフィードが削除されるか" do
    login_user("loglog.user.3@gmail.com", "aaaa")
    visit log_path(logs(:log_3))
    fill_in "value", with: "5.0"
    fill_in "valued_on", with: Date.current
    click_button "追加"

    visit user_path(users(:user_3))
    accept_confirm do
      click_link "削除"
    end
    login_user("loglog.user.1@gmail.com", "aaaa")
    visit root_path
    assert_no_text "Brunoさんが「ログのタイトル3」を更新しました。"
  end
end
