# frozen_string_literal: true

class Log < ApplicationRecord
  enum color: {
    red: 0,
    blue: 1,
    green: 2,
    orange: 3,
    purple: 4,
    pink: 5,
    brown: 6,
  }, _prefix: true

  enum graph: {
    column: 0,
    line: 1
  }, _prefix: true

  validates :title,  presence: true
  validates :description,  presence: true

  belongs_to :user

  has_many :values
  has_many :log_followings

  has_many :feeds, dependent: :destroy

  after_create LogCallbacks.new

  def following_by?(user)
    log_followings.where(user_id: user.id).exists?
  end
end
