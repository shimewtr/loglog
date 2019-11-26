# frozen_string_literal: true

class ValueCallbacks
  def after_create(value)
    log = Log.find(value.log_id)
    sender_user = User.find(log.user_id)
    feed = log.feeds.new(
      # ToDo user_id
      user_id: log.user_id,
      sender_id: log.user_id,
      action: :value_create
    )
    feed.save if feed.valid?
  end
end
