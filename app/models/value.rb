# frozen_string_literal: true

class Value < ApplicationRecord
  belongs_to :log, touch: true

  validates :value,
            presence: { message: "を入力してください。" },
            numericality: {
              allow_blank: true,
              message: "は数値のみ入力できます。"
            }

  validates :valued_on,
            presence: { message: "を入力してください。" },
            uniqueness: { scope: :log, message: "が重複する値は作成できません。" }

  scope :default_order, -> { order(valued_on: :asc) }

  after_create ValueCallbacks.new
end
