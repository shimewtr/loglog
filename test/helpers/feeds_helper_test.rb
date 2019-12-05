# frozen_string_literal: true

require "test_helper"

class FeedsHelperTest < ActionView::TestCase
  test "feed_text" do
    feed = feeds(:feed_1)
    assert_equal feed_text(feed), "Jonathanさんが「ログのタイトル2」を作成しました。"

    feed = feeds(:feed_2)
    assert_equal feed_text(feed), "Jonathanさんが「ログのタイトル2」を更新しました。"

    feed = feeds(:feed_3)
    assert_equal feed_text(feed), "Robertさんにフォローされました。"

    feed = feeds(:feed_4)
    assert_equal feed_text(feed), "BrunoさんがJonathanさんをフォローしました。"
  end

  test "feed_link" do
    feed = feeds(:feed_1)
    assert_equal feed_link(feed), log_path(logs(:log_2))

    feed = feeds(:feed_2)
    assert_equal feed_link(feed), log_path(logs(:log_2))

    feed = feeds(:feed_3)
    assert_equal feed_link(feed), user_path(users(:user_1))

    feed = feeds(:feed_4)
    assert_equal feed_link(feed), user_path(users(:user_2))
  end
end
