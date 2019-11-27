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

    assert_equal user_1.gravatar_url, "https://www.gravatar.com/avatar/65206b63312986c93f8222a35ebece03?r=g&d=mp"
    assert_equal user_2.gravatar_url, "https://www.gravatar.com/avatar/596a3e0f7209b8628b1e88be053ef0e2?r=g&d=mp"
  end
end
