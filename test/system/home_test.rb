# frozen_string_literal: true

require "application_system_test_case"

class HomeTest < ApplicationSystemTestCase
  test "ログインしていないユーザーにはサービスの説明が表示されるか" do
    visit root_path
    assert_text "LogLogとは日々のちょっとした変化を残せるWebサービスです。"

    login_user("loglog.user.1@gmail.com", "aaaa")
    visit root_path
    assert_no_text "LogLogとは日々のちょっとした変化を残せるWebサービスです。"
  end

  test "ログインしているユーザーに新着情報とフォローしているログが表示されるか" do
    login_user("loglog.user.1@gmail.com", "aaaa")
    visit root_path
    assert_text "新着情報"
    assert_text "フォローしているログ"
  end

  test "アドミンユーザーにはアドミンメニューが表示されるか" do
    visit root_path
    assert_no_text "ユーザー一覧"

    login_user("loglog.user.1@gmail.com", "aaaa")
    assert_no_text "ユーザー一覧"

    login_user("admin@gmail.com", "aaaa")
    assert_text "ユーザー一覧"
  end
end
