# frozen_string_literal: true

class CreateFollowRelationships < ActiveRecord::Migration[6.0]
  def change
    create_table :follow_relationships do |t|
      t.integer :following_id
      t.integer :follower_id

      t.timestamps
    end
  end
end
