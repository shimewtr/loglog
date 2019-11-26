# frozen_string_literal: true

class LogFollowing < ApplicationRecord
  belongs_to :user
  belongs_to :log
  validates :user_id, presence: true
  validates :log_id, presence: true
end
