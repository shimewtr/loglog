# frozen_string_literal: true

class Log < ApplicationRecord
  validates :title,  presence: true
  validates :description,  presence: true

  belongs_to :user

  has_many :values
  has_many :log_followings

  def following_by?(user)
    log_followings.where(user_id: user.id).exists?
  end
end
