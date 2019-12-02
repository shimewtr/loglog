# frozen_string_literal: true

require "test_helper"

class LogsHelperTest < ActionView::TestCase
  test "chart_color" do
    assert_equal chart_color(logs(:log_red)), "#F44336"
    assert_equal chart_color(logs(:log_blue)), "#3F51B5"
    assert_equal chart_color(logs(:log_green)), "#4CAF50"
    assert_equal chart_color(logs(:log_orange)), "#FF9800"
    assert_equal chart_color(logs(:log_purple)), "#673AB7"
    assert_equal chart_color(logs(:log_pink)), "#E91E63"
    assert_equal chart_color(logs(:log_brown)), "#795548"
  end

  test "log_submit_label" do
    assert_equal log_submit_label(:new), "作成"
    assert_equal log_submit_label(:edit), "更新"
  end
end
