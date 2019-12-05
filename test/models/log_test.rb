# frozen_string_literal: true

require "test_helper"

class LogTest < ActiveSupport::TestCase
  test "followed_by?" do
    user = users(:user_1)
    log = logs(:log_2)
    assert log.followed_by?(user)

    user = users(:user_3)
    log = logs(:log_1)
    assert_not log.followed_by?(user)
  end
end
