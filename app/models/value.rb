# frozen_string_literal: true

class Value < ApplicationRecord
  belongs_to :log

  validates :value, numericality: true
end
