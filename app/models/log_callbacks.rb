# frozen_string_literal: true

class LogCallbacks
  def after_create(log)
    create_feed(log)
  end

  private
    def create_feed(log)
      sender = User.find(log.user_id)
      target_users = sender.followers
      target_users.each do |target|
        Feed.create_log(target, log)
      end
    end
end
