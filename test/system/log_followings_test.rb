# frozen_string_literal: true

require "application_system_test_case"

class LogFollowingsTest < ApplicationSystemTestCase
  setup do
    login_user("loglog.user.1@gmail.com", "aaaa")
    @user_1 = users(:user_1)
    @user_2 = users(:user_2)
    @log_1 = logs(:log_1)
    @log_2 = logs(:log_2)
    @log_3 = logs(:log_3)
  end

  test "別のユーザーにしかフォローリンクが表示されないか" do
    visit log_path(@log_1)
    assert_no_selector(".log-header__link--follow")
    assert_no_selector(".log-header__link--unfollow")

    visit log_path(@log_3)
    assert_selector(".log-header__link--unfollow")

    logout
    visit log_path(@log_3)
    assert_no_selector(".log-header__link--follow")
    assert_no_selector(".log-header__link--unfollow")
  end

  test "ログをフォローできるか" do
    assert_not @log_3.followed_by?(@user_2)
    login_user("loglog.user.2@gmail.com", "aaaa")
    visit log_path(@log_3)
    find(".log-header__link--follow").click
    sleep(1)
    assert @log_3.followed_by?(@user_2)
  end

  test "ログをアンフォローできるか" do
    assert @log_2.followed_by?(@user_1)
    visit log_path(@log_2)
    find(".log-header__link--unfollow").click
    sleep(1)
    assert_not @log_2.followed_by?(@user_1)
  end
end
