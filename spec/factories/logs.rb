# frozen_string_literal: true

FactoryBot.define do
  factory :log do
    title { "テストログのタイトル" }
    description { "テストログの説明文" }
    color { "green" }
    graph { "column" }
    user
  end
end
