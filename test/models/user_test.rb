# frozen_string_literal: true

require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "followed_by?" do
    user_1 = users(:user_1)
    user_2 = users(:user_2)
    user_3 = users(:user_3)
    user_4 = users(:user_4)
    assert user_1.followed_by?(user_2)
    assert user_2.followed_by?(user_1)
    assert_not user_3.followed_by?(user_2)
    assert_not user_4.followed_by?(user_1)
  end

  test "gravatar_url" do
    user_1 = users(:user_1)
    user_2 = users(:user_2)

    assert_equal user_1.gravatar_url, "https://www.gravatar.com/avatar/bc08da1a0ffc4f7818bc6953a965b648?r=g&d=mp"
    assert_equal user_2.gravatar_url, "https://www.gravatar.com/avatar/19651a4ce7fd3e4676a80a697d2875af?r=g&d=mp"
  end
end
