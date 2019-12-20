# frozen_string_literal: true

FactoryBot.define do
  factory :log_following do
    user
    log
  end
end
