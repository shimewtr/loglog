# frozen_string_literal: true

require "application_system_test_case"

class LogsTest < ApplicationSystemTestCase
  setup do
    login_user("loglog.user.1@gmail.com", "aaaa")
  end

  test "Logの一覧が表示されるか" do
    visit root_path
    assert_text "ログのタイトル1"
    assert_text "ログのタイトル2"
  end

  test "Logを作成できるか" do
    visit root_path
    click_on "作成"
    assert_text "新しいログ"

    fill_in "log_title", with: "作成するログのタイトル"
    fill_in "log_description", with: "作成するログの説明文"
    click_button "作成"

    assert_text "作成するログのタイトルを作成しました。"
  end

  test "Logの詳細ページが表示できるか" do
    visit log_path(id: 1)
    assert_text "ログのタイトル1"
    assert_text "ログの説明文1"
  end

  test "Logを更新できるか" do
    visit log_path(id: 1)
    click_link "編集"

    fill_in "log_title", with: "更新後のログのタイトル"
    fill_in "log_description", with: "更新後のログの説明文"
    click_button "更新"

    assert_text "更新後のログのタイトルを更新しました。"
    assert_text "更新後のログのタイトル"
    assert_text "更新後のログの説明文"
  end

  test "Logを削除できるか" do
    visit log_path(id: 1)
    accept_confirm do
      click_link "削除"
    end
    assert_text "ログのタイトル1を削除しました。"
  end

  test "ログ作成したユーザー以外は編集が表示されないか" do
    visit log_path(id: 1)
    assert_text "編集"

    visit log_path(id: 2)
    assert_no_text "編集"
  end
end
