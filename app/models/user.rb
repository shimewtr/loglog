# frozen_string_literal: true

class User < ApplicationRecord
  authenticates_with_sorcery!

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :email, uniqueness: true

  has_many :logs

  has_many :log_followings
  has_many :follow_logs, through: :log_followings, source: :log

  has_many :active_feeds, class_name: "Feed", foreign_key: "sender_id", dependent: :destroy
  has_many :passive_feeds, class_name: "Feed", foreign_key: "user_id", dependent: :destroy
end
