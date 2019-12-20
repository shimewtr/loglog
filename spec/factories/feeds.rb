# frozen_string_literal: true

FactoryBot.define do
  factory :feed do
    user
    association :sender, factory: :user
    association :followed, factory: :user
    log { nil }
    action { "log_create" }
  end
end
