# frozen_string_literal: true

require "application_system_test_case"

class FllowRelationshipsTest < ApplicationSystemTestCase
  setup do
    login_user("loglog.user.1@gmail.com", "aaaa")
    @user_1 = users(:user_1)
    @user_2 = users(:user_2)
    @user_3 = users(:user_3)
    @user_4 = users(:user_4)
  end

  test "別のユーザーにしかフォローリンクが表示されないか" do
    visit user_path(@user_1)
    assert_no_selector(".user-profile-links__link--follow")
    assert_no_selector(".user-profile-links__link--unfollow")

    visit user_path(@user_4)
    assert_selector(".user-profile-links__link--follow")

    logout
    visit user_path(@user_4)
    assert_no_selector(".user-profile-links__link--follow")
    assert_no_selector(".user-profile-links__link--unfollow")
  end

  test "ユーザーをフォローできるか" do
    visit user_path(@user_4)
    assert_not @user_4.followed_by?(@user_1)
    assert_no_text @user_1.name
    find(".user-profile-links__link--follow").click
    visit user_path(@user_4)
    find(".relation-tab__item-follower").click
    assert_text @user_1.name
    assert @user_4.followed_by?(@user_1)
  end

  test "ユーザーをアンフォローできるか" do
    visit user_path(@user_3)
    assert @user_3.followed_by?(@user_1)
    find(".relation-tab__item-follower").click
    assert_text @user_1.name
    find(".user-profile-links__link--unfollow").click
    visit user_path(@user_3)
    find(".relation-tab__item-follower").click
    assert_no_text @user_1.name
    assert_not @user_3.followed_by?(@user_1)
  end
end
