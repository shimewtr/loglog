# frozen_string_literal: true

class Feed < ApplicationRecord
  enum action: { log_create: 0, value_create: 1 }

  belongs_to :user, class_name: "User", foreign_key: "user_id"
  belongs_to :sender, class_name: "User", foreign_key: "sender_id"
  belongs_to :log

  validates :user_id, presence: true
  validates :sender_id, presence: true
  validates :log_id, presence: true
end
