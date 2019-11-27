# frozen_string_literal: true

require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  setup do
    @user = users(:user_1)
  end

  test "Userを作成できるか" do
    visit new_user_path
    fill_in "user_email", with: "test@email.com"
    fill_in "user_password", with: "aaaa"
    fill_in "user_password_confirmation", with: "aaaa"
    click_button "作成"
    assert_text "ユーザーを作成しました。"
  end

  test "Userページが正しく表示されるか" do
    login_user("user_1@email.com", "aaaa")
    visit user_path(@user)
    assert_text "user_1@email.com"
  end

  test "ログインユーザー以外は編集と削除が表示されないか" do
    login_user("user_1@email.com", "aaaa")
    visit user_path(@user)
    assert_text "編集"
    assert_text "削除"

    visit user_path(users(:user_2))
    assert_no_text "編集"
    assert_no_text "削除"
  end

  test "Userの情報を更新できるか" do
    login_user("user_1@email.com", "aaaa")
    visit user_path(@user)
    click_link "編集"

    fill_in "user_email", with: "update_email@test.com"
    click_button "作成"
    assert_text "更新しました"
    assert_text "update_email@test.com"
  end

  test "Userを削除できるか" do
    login_user("user_1@email.com", "aaaa")
    visit user_path(@user)
    accept_confirm do
      click_link "削除"
    end
    assert_text "削除しました"
  end
end
