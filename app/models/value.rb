# frozen_string_literal: true

class Value < ApplicationRecord
  belongs_to :log

  validates :value, numericality: true
  validates :valued_on, presence: true, uniqueness: { scope: :log }

  after_create ValueCallbacks.new
end
