# frozen_string_literal: true

FactoryBot.define do
  factory :follow_relationship do
    association :following, factory: :user
    association :follower, factory: :user
  end
end
