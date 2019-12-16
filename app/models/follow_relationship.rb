# frozen_string_literal: true

class FollowRelationship < ApplicationRecord
  belongs_to :following, class_name: "User"
  belongs_to :follower, class_name: "User"

  after_create FollowRelationshipCallbacks.new
  after_destroy FollowRelationshipCallbacks.new

  validates :following_id, uniqueness: { scope: :follower_id }
end
