# frozen_string_literal: true

class CreateValues < ActiveRecord::Migration[6.0]
  def change
    create_table :values do |t|
      t.integer :log_id
      t.float :value

      t.timestamps
    end
  end
end
