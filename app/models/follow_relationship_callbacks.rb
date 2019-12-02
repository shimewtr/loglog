# frozen_string_literal: true

class FollowRelationshipCallbacks
  def after_create(follow_relationship)
    create_feed(follow_relationship)
  end

  def after_destroy(follow_relationship)
    destroy_feed(follow_relationship)
  end

  private
    def create_feed(follow_relationship)
      sender = follow_relationship.following
      follower = follow_relationship.follower
      target_users = sender.followers

      Feed.user_followed(follower, sender)
      target_users.each do |target|
        if target != follower
          Feed.following_user_follow(target, sender, follower)
        end
      end
    end

    def destroy_feed(follow_relationship)
      sender = follow_relationship.following
      follower = follow_relationship.follower

      Feed.destroy_user_followed(follower, sender)
      Feed.destroy_following_user_follow(sender, follower)
    end
end
