
# frozen_string_literal: true

module FeedsHelper
  def feed_text(feed)
    case feed.action
    when "log_create"
      "#{feed.id}kitemasu log_create"
    when "value_create"
      "#{feed.id}kitemasu value_create"
    else
      "#{feed.id}kitemasu else"
    end
  end
end
