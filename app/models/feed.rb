# frozen_string_literal: true

class Feed < ApplicationRecord
  enum action: { log_create: 0, value_create: 1, user_followed: 2, following_follow: 3 }

  belongs_to :user, class_name: "User", foreign_key: "user_id"
  belongs_to :sender, class_name: "User", foreign_key: "sender_id"
  belongs_to :followed, class_name: "User", foreign_key: "followed_id", optional: true
  belongs_to :log, optional: true

  validates :user_id, presence: true
  validates :sender_id, presence: true

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

  def self.user_followed(target, sender)
    Feed.create!(
      user_id: target.id,
      sender_id: sender.id,
      action: :user_followed
    )
  end

  def self.following_user_follow(target, sender, follower)
    Feed.create!(
      user_id: target.id,
      sender_id: sender.id,
      followed_id: follower.id,
      action: :following_follow
    )
end
