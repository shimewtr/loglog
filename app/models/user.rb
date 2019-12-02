# frozen_string_literal: true

class User < ApplicationRecord
  authenticates_with_sorcery!

  validates :email,
            presence: { message: "を入力してください。" },
            uniqueness:  { message: "は既に登録されています。" },
            format: {
              allow_blank: true,
              with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i,
              message: "の形式が正しくありません。"
            }

  validates :name,
            presence:  { message: "を入力してください。" },
            length: { maximum: 15 },
            format: {
              allow_blank: true,
              with: /\A\w+\z/,
              message: "は英文字と_（アンダーバー）のみが使用できます"
            }

  validates :password,
            length: { minimum: 4, too_short: "は4文字以上で入力してください。", },
            if: -> { new_record? || changes[:crypted_password] }

  validates :password,
            confirmation: { message: "が一致しません。" },
            if: -> { new_record? || changes[:crypted_password] }

  validates :password_confirmation,
            presence: { message: "を入力してください。" },
            if: -> { new_record? || changes[:crypted_password] }

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
