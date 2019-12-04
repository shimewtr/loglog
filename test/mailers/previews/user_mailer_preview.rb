# frozen_string_literal: true

class UserMailerPreview < ActionMailer::Preview
  def activation_needed_email
    UserMailer.activation_needed_email
  end

  def activation_success_email
    UserMailer.activation_success_email
  end
end
