# frozen_string_literal: true

class AddColorGraphToLog < ActiveRecord::Migration[6.0]
  def change
    add_column :logs, :color, :integer, default: 0
    add_column :logs, :graph, :integer, default: 0
  end
end
