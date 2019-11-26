# frozen_string_literal: true

class CreateFeeds < ActiveRecord::Migration[6.0]
  def change
    create_table :feeds do |t|
      t.integer :user_id
      t.integer :sender_id
      t.integer :log_id
      t.integer :action

      t.timestamps
    end
  end
end
