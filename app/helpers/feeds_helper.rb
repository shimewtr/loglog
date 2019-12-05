
# frozen_string_literal: true

module FeedsHelper
  def feed_text(feed)
    sender = User.find(feed.sender_id)

    if feed.log_id
      log = Log.find(feed.log_id)
    end

    if feed.followed_id
      follower = User.find(feed.followed_id)
    end

    case feed.action
    when "log_create"
      "#{sender.name}さんが「#{log.title}」を作成しました。"
    when "value_create"
      "#{sender.name}さんが「#{log.title}」を更新しました。"
    when "user_followed"
      "#{sender.name}さんにフォローされました。"
    when "following_follow"
      "#{sender.name}さんが#{follower.name}さんをフォローしました。"
    end
  end

  def feed_link(feed)
    case feed.action
    when "log_create"
      log_path(feed.log)
    when "value_create"
      log_path(feed.log)
    when "user_followed"
      user_path(feed.sender)
    when "following_follow"
      user_path(feed.followed)
    end
  end
end
