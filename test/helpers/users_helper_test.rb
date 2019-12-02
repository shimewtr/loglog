# frozen_string_literal: true

require "test_helper"

class UsersHelperTest < ActionView::TestCase
  test "user_submit_label" do
    assert_equal user_submit_label(:new), "作成"
    assert_equal user_submit_label(:edit), "更新"
  end
end
