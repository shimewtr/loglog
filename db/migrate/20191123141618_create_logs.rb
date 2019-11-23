# frozen_string_literal: true

class CreateLogs < ActiveRecord::Migration[6.0]
  def change
    create_table :logs do |t|
      t.string :title
      t.string :description

      t.timestamps
    end
  end
end
