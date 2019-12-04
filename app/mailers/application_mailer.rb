# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: "LogLog <info@loglog.me>"
  layout "mailer"
end
