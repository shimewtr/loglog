# frozen_string_literal: true

class User < ApplicationRecord
  authenticates_with_sorcery!

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :email, presence: true, uniqueness: true

  validates :name,
            presence: true,
            uniqueness: true,
            length: { maximum: 15 },
            format: {
              allow_blank: true,
              with: /\A\w+\z/,
              message: "は英文字と_（アンダーバー）のみが使用できます"
            }

  validates :description, length: { maximum: 200, too_long: "は最大200文字まで入力できます。" }

  has_many :logs, dependent: :destroy

  has_many :log_followings
  has_many :follow_logs, through: :log_followings, source: :log

  has_many :active_relationships, class_name: "FollowRelationship", foreign_key: :following_id
  has_many :followings, through: :active_relationships, source: :follower

  has_many :passive_relationships, class_name: "FollowRelationship", foreign_key: :follower_id
  has_many :followers, through: :passive_relationships, source: :following

  has_many :active_feeds, class_name: "Feed", foreign_key: "sender_id", dependent: :destroy
  has_many :passive_feeds, class_name: "Feed", foreign_key: "user_id", dependent: :destroy

  def followed_by?(user)
    passive_relationships.find_by(following_id: user.id).present?
  end

  def gravatar_url
    "https://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(self.email.downcase)}?r=g&d=mp"
  end
end
