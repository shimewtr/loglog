# frozen_string_literal: true

class CreateLogFollowings < ActiveRecord::Migration[6.0]
  def change
    create_table :log_followings do |t|
      t.integer :user_id
      t.integer :log_id

      t.timestamps
    end
  end
end
