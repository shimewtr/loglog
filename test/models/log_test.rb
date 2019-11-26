# frozen_string_literal: true

require "test_helper"

class LogTest < ActiveSupport::TestCase
  test "following_by?" do
    user = users(:user_1)
    log = logs(:log_1)
    assert log.following_by?(user)

    user = users(:user_2)
    log = logs(:log_2)
    assert_not log.following_by?(user)
  end
end
