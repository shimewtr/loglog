# frozen_string_literal: true

require "application_system_test_case"

class ValuesTest < ApplicationSystemTestCase
  setup do
    login_user("user_1@email.com", "aaaa")
  end

  test "Logページにvalueが表示されるか" do
    visit log_path(logs(:log_1))
    assert_text "1.1"
    assert_text "1.2"
  end

  test "Logにvalueを追加できるか" do
    visit log_path(logs(:log_1))
    fill_in "value", with: "5.0"
    click_button "追加"
    assert_text "5.0"
  end

  test "valueを削除できるか" do
    visit log_path(logs(:log_1))
    click_link "数値を削除", match: :first
    assert_no_text "1.1"
  end
end
