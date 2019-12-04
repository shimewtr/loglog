# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def activation_needed_email(user)
    @user = user
    @url  = "http://0.0.0.0:3000/users/#{user.activation_token}/activate"

    mail to: user.email, subject: "Welcome to My Awesome Site"
  end

  def activation_success_email(user)
    @user = user
    # @url = "#{root_url}/login"
    @url = "http://0.0.0.0:3000/login"

    mail to: user.email, subject: "Your acount is now activate"
    end
end
