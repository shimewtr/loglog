# frozen_string_literal: true

class LogCallbacks
  def after_create(log)
    sender_user = User.find(log.user_id)
    feed = log.feeds.new(
      # ToDo user_id
      user_id: log.user_id,
      sender_id: log.user_id,
      action: :log_create
    )
    feed.save if feed.valid?
  end
end
