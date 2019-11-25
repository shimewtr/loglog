# frozen_string_literal: true

class Log < ApplicationRecord
  validates :title,  presence: true
  validates :description,  presence: true

  has_many :values
end
