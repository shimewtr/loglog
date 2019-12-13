# frozen_string_literal: true

Ransack.configure do |config|
  config.add_predicate "eq_day",
    arel_predicate: "between",
    formatter: proc { |v| v.beginning_of_day...v.end_of_day }
end
