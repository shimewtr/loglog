# frozen_string_literal: true

class ValueCallbacks
  def after_create(value)
    create_feed(value)

    # log = Log.find(value.log_id)
    # sender_user = User.find(log.user_id)
    # feed = log.feeds.new(
    #   user_id: log.user_id,
    #   sender_id: log.user_id,
    #   action: :value_create
    # )
    # feed.save if feed.valid?
  end

  private
    def create_feed(value)
      log = Log.find(value.log_id)
      sender = User.find(log.user_id)
      target_users = sender.followers
      target_users.each do |target|
        Feed.create_value(target, log)
      end
    end
end
