# frozen_string_literal: true

require "application_system_test_case"

class SessionsTest < ApplicationSystemTestCase
  test "ログインが正しくできるか" do
    visit welcome_path
    fill_in("email", with: "loglog.user.1@gmail.com")
    fill_in("password",   with: "aaaa")
    click_button "ログイン"
    assert_equal root_path, current_path
  end

  test "ユーザー情報を間違えるとログインできないか" do
    visit welcome_path
    fill_in("email", with: "loglog.user.1@gmail.com")
    fill_in("password",   with: "bbbb")
    click_button "ログイン"
    assert_equal login_path, current_path
    assert_text "メールアドレスかパスワードが違います。"
  end
end
