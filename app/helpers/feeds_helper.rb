
# frozen_string_literal: true

module FeedsHelper
  def feed_text(feed)
    sender = User.find(feed.sender_id)
    log = Log.find(feed.log_id)
    case feed.action
    when "log_create"
      "#{sender.email} さんが「#{log.title}」を作成しました。"
    when "value_create"
      "#{sender.email} さんが「#{log.title}」を更新しました。"
    end
  end
end
