# frozen_string_literal: true

require "test_helper"

class ApplicationHelperTest < ActionView::TestCase
  test "page_title" do
    assert_equal "LogLog", page_title

    @page_title = "タイトルのテスト"
    assert_equal "タイトルのテスト | LogLog", page_title
  end
end
