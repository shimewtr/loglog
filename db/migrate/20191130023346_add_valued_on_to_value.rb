# frozen_string_literal: true

class AddValuedOnToValue < ActiveRecord::Migration[6.0]
  def change
    add_column :values, :valued_on, :date
  end
end
