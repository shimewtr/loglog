# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def activation_needed_email(user)
    @user = user
    mail to: user.email, subject: "【LogLog】仮登録完了のお知らせ / 本登録のお願い"
  end

  def activation_success_email(user)
    @user = user
    mail to: user.email, subject: "【LogLog】本登録完了のお知らせ"
    end
end
