# frozen_string_literal: true

class AddFollowedUserToFeed < ActiveRecord::Migration[6.0]
  def change
    add_column :feeds, :followed_id, :integer, default: nil
  end
end
