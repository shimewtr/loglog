# frozen_string_literal: true

class AddUserIdToLog < ActiveRecord::Migration[6.0]
  def change
    add_column :logs, :user_id, :integer, null: false, default: 0
  end
end
