# frozen_string_literal: true

require "test_helper"

class UserMailerTest < ActionMailer::TestCase
  test "activation_needed_email" do
    user = users(:user_1)
    mail = UserMailer.activation_needed_email(user)
    assert_equal "【LogLog】仮登録完了のお知らせ / 本登録のお願い", mail.subject
    assert_equal ["info@loglog.me"], mail.from
    assert_equal ["loglog.user.1@gmail.com"], mail.to
    assert_match "以下のリンクからユーザー認証を完了してください。", mail.body.encoded
  end

  test "activation_success_email" do
    user = users(:user_1)
    mail = UserMailer.activation_success_email(user)
    assert_equal "【LogLog】本登録完了のお知らせ", mail.subject
    assert_equal ["info@loglog.me"], mail.from
    assert_equal ["loglog.user.1@gmail.com"], mail.to
    assert_match "以下のリンクからログインすることができます。", mail.body.encoded
  end
end
