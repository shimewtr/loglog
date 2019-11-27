# frozen_string_literal: true

class Feed < ApplicationRecord
  enum action: { log_create: 0, value_create: 1, followerd: 2, following: 3 }

  belongs_to :user, class_name: "User", foreign_key: "user_id"
  belongs_to :sender, class_name: "User", foreign_key: "sender_id"
  belongs_to :log

  validates :user_id, presence: true
  validates :sender_id, presence: true
  validates :log_id, presence: true

  scope :default_order, -> { order(created_at: :desc) }

  def self.create_log(target, log)
    Feed.create!(
      user_id: target.id,
      sender_id: log.user_id,
      log_id: log.id,
      action: :log_create
    )
  end

  def self.create_value(target, log)
    Feed.create!(
      user_id: target.id,
      sender_id: log.user_id,
      log_id: log.id,
      action: :value_create
    )
  end
end
