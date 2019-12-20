# frozen_string_literal: true

FactoryBot.define do
  factory :value do
    value { 1 }
    valued_on { Date.today }
    log
  end
end
