# frozen_string_literal: true

require "application_system_test_case"

class ValuesTest < ApplicationSystemTestCase
  setup do
    login_user("loglog.user.1@gmail.com", "aaaa")
  end

  test "Logページにvalueが表示されるか" do
    visit log_path(logs(:log_1))
    assert_text "1.1"
    assert_text "1.2"
  end

  test "Logにvalueを追加できるか" do
    visit log_path(logs(:log_1))
    fill_in "value", with: "5.0"
    fill_in "valued_on", with: Date.current
    click_button "追加"
    assert_text "値を追加しました。"
    assert_text "5.0"
  end

  test "valueを削除できるか" do
    visit log_path(logs(:log_1))
    click_link "数値を削除", match: :first
    assert_text "値を削除しました。"
    assert_no_text "1.1"
  end

  test "自分が作成していないlogにvalueの入力欄が表示されないか" do
    visit log_path(logs(:log_1))
    assert_selector("form")

    visit log_path(logs(:log_2))
    assert_no_selector("form")
  end
end
