# frozen_string_literal: true

require "application_system_test_case"

class FllowRelationshipsTest < ApplicationSystemTestCase
  setup do
    login_user("user_1@email.com", "aaaa")
    @user_1 = users(:user_1)
    @user_2 = users(:user_2)
    @user_3 = users(:user_3)
    @user_4 = users(:user_4)
  end

  test "ユーザーをフォローできるか" do
    visit user_path(@user_4)
    assert_not @user_4.followed_by?(@user_1)
    assert_no_text @user_1.id
    click_link "フォロー"
    assert_text @user_1.id
    assert @user_4.followed_by?(@user_1)
  end

  test "ユーザーをアンフォローできるか" do
    visit user_path(@user_3)
    assert @user_3.followed_by?(@user_1)
    assert_text @user_1.id
    click_link "フォロー解除"
    assert_no_text @user_1.id
    assert_not @user_3.followed_by?(@user_1)
  end
end
