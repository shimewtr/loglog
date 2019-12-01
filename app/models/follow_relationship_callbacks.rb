# frozen_string_literal: true

class FollowRelationshipCallbacks
  def after_create(follow_relationship)
    create_feed(follow_relationship)
  end

    private
      def create_feed(follow_relationship)
        sender = User.find(follow_relationship.following_id)
        follower = User.find(follow_relationship.follower_id)
        target_users = sender.followers

        Feed.user_followed(follower, sender)
        target_users.each do |target|
          if target != follower
            Feed.following_user_follow(target, sender, follower)
          end
        end
      end
end
